//
//  LoginView.swift
//  OnBoarding
//
//  Created by 서원지 on 11/8/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Common
import SwiftUI
import DesignSystem
import Authorization
import AuthenticationServices
import PopupView
import Home
import Core


public struct LoginView: View {
    @StateObject var appState: OnBoardingAppState = OnBoardingAppState()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    @StateObject var viewModel: OnBoardingViewModel
    @StateObject var commonViewViewModel: CommonViewViewModel = CommonViewViewModel()
    
    @StateObject var sheetManger: SheetManager = SheetManager()
    
    public init(viewModel: OnBoardingViewModel){
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack(path: $viewModel.viewPath) {
            VStack(spacing: .zero) {
               
                loadingAnimationView()
                
                cookWiseSayingView()
                
                authButton()
                
            }
            .navigationDestination(for: ViewState.self) { state in
                switch state {
                    
                case .isStartLogin:
                    OnBoardingLoginView(viewModel: viewModel)
                        .navigationBarBackButtonHidden()
                case .isStartEnter:
                    OnBoardingView(viewModel: viewModel)
                        .navigationBarBackButtonHidden()
                case .isStartServiceAgreement:
                    ServiceUseAgreementView(path: $viewModel.viewPath)
                        .environmentObject(viewModel)
                case .isServiceAgreeComplete:
                    LoginSettingView(viewModel: self.viewModel)
                case .isNickNameComplete:
                    LoginJobSettingView(viewModel: self.viewModel)
                 case .isJobSettingComplete:
                    CompleteLoginView(viewModel: self.viewModel)
                case .isCompleteLogin:
                    FavoriteWiseChooseView(viewModel: self.viewModel)
                case .isStartChoiceFavorite:
                    SelectCategoryView(viewModel: self.viewModel)
                case .isSelectedCategory:
                    SelectCharacterView(viewModel: self.viewModel)
                case .isSelectedCharacter:
                    OnBoardingPushView(viewModel: self.viewModel)

                case .isCompleteOnboarding:
                    CompletOnBoardingView(viewModel: viewModel)
                        .environmentObject(authViewModel)
                case .isDeniedNoti:
                    RecomandPushNotificationView(viewModel: self.viewModel)
                case .isLoginned:
                    CoreView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.firstUserPOPUP)
                        .environmentObject(authViewModel)
                        .environmentObject(sheetManger)
                }
            }
            .onAppear{
                authViewModel.getRefreshToken()
                if authViewModel.isDeletAuth {
                    authViewModel.deleteAuth = true
                }
                
                if authViewModel.isLoginCheck {
                    viewModel.viewPath.append(ViewState.isLoginned)
                }
            }
            .popup(isPresented: $authViewModel.deleteAuth) {
                WithDrawPOPUP(
                    image: .empty,
                    title: "이용해 주셔서 감사합니다",
                    subTitle: "주신 의견에 반영하여\n 더나은 명언 제과점이 되겠습니다",
                    confirmAction: {},
                    cancelAction: {
                        authViewModel.deleteAuth = false
                        viewModel.isSignUP = false
                        viewModel.alreadySignUP = false
                    }, noImage: true,
                    noImageButton: true
                )
            } customize: { popup in
                popup
                    .type(.default)
                    .position(.bottom)
                    .animation(.easeIn)
                    .closeOnTap(true)
                    .closeOnTapOutside(true)
                    .backgroundColor(.basicBlackDimmed)
            }

        }
    }
    
    @ViewBuilder
    private func loadingAnimationView() -> some View {
        
        Spacer()
            .frame(height: UIScreen.screenWidth*0.2)
        
        HStack(spacing: .zero) {
            Image(asset: .house)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth/2, height: UIScreen.main.bounds.height == 667 ? 300
                       : 400)
            
            Spacer()
        }
    }
    
    
    @ViewBuilder
    private func cookWiseSayingView() -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Spacer()
                .frame(height: 12)
            
            HStack {
                Spacer()
                    .frame(width: UIScreen.screenWidth*0.08 + 10)
                
                
                Text("어제 보다 오늘 더 ")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(.basicGray7)
                
                Spacer()
            }
            .offset(x: -10)
            
            Spacer()
                .frame(height: 8)
            
            HStack {
                Spacer()
                    .frame(width: UIScreen.screenWidth*0.08 + 10)
                Text("맛있는 명언을 굽고 있어요")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(.basicGray7)
                
                Spacer()
            }
            .offset(x: -10)
            
           
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func authButton() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.1)
        
        VStack(spacing: .zero) {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primaryOrange, style: .init(lineWidth: 2))
                .frame(height: 56)
                .overlay {
                    Text("로그인하기")
                        .foregroundStyle(Color.primaryOrangeText)
                        .pretendardFont(family: .SemiBold, size: 16)
                }
                .onTapGesture {
                    viewModel.viewPath.append(ViewState.isStartLogin)
                }
                
            Spacer()
                .frame(height: 8)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.primaryOrange)
                .frame(height: 56)
                .overlay {
                    Text("회원가입하기")
                        .foregroundStyle(Color.basicWhite)
                        .pretendardFont(family: .SemiBold, size: 16)
                }
                .onTapGesture {
                    viewModel.isSignUP = true
                    viewModel.alreadySignUP = false
                    viewModel.goToLoginRegisterView.toggle()
                    viewModel.viewPath.append(ViewState.isStartEnter)
                }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Layout Metrics
extension LoginView {
    public enum Label {
        public static let viewStringKey: String = "LoginView"
    }
}

public enum ViewState:String, Hashable {
    case isStartLogin
    case isStartEnter
    case isStartServiceAgreement
    case isServiceAgreeComplete
    case isNickNameComplete
    case isJobSettingComplete
    case isCompleteLogin
    case isStartChoiceFavorite
    case isSelectedCategory
    case isSelectedCharacter
    case isCompleteOnboarding
    case isDeniedNoti
    case isLoginned
}
