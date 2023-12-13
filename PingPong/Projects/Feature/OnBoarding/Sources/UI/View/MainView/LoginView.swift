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
import Model


@available(iOS 16.4, *)
public struct LoginView: View {
    @StateObject var appState: OnBoardingAppState = OnBoardingAppState()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    @StateObject var viewModel: OnBoardingViewModel
    @StateObject var commonViewViewModel: CommonViewViewModel
    @StateObject var sheetManager = SheetManager()
    
    public init(viewModel: OnBoardingViewModel, commonViewViewModel: CommonViewViewModel){
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._commonViewViewModel = StateObject(wrappedValue: commonViewViewModel)
    }
    
    public var body: some View {
        NavigationStack(path: $commonViewViewModel.viewPath) {
            VStack(spacing: .zero) {
               
                loadingAnimationView()
                
                cookWiseSayingView()
                
                authButton()
                
            }
            .navigationDestination(for: ViewState.self) { state in
                switch state {
                    
                case .isStartLogin:
                    OnBoardingLoginView(viewModel: viewModel, commonViewViewModel: commonViewViewModel, authViewModel: authViewModel)
                        .navigationBarBackButtonHidden()
                case .isStartEnter:
                    OnBoardingView(viewModel: viewModel, commonViewViewModel: commonViewViewModel)
                        .navigationBarBackButtonHidden()
                case .isStartServiceAgreement:
                    ServiceUseAgreementView(commonViewViewModel: commonViewViewModel)
                        .environmentObject(viewModel)
                case .isServiceAgreeComplete:
                    LoginSettingView(viewModel: self.viewModel, commonViewViewModel: self.commonViewViewModel)
                case .isNickNameComplete:
                    LoginJobSettingView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                 case .isJobSettingComplete:
                    CompleteLoginView(viewModel: self.viewModel, commonViewViewModel: self.commonViewViewModel)
                case .isCompleteLogin:
                    FavoriteWiseChooseView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                case .isStartChoiceFavorite:
                    SelectCategoryView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                case .isSelectedCategory:
                    SelectCharacterView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                case .isSelectedCharacter:
                    OnBoardingPushView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)

                case .isCompleteOnboarding:
                    CompletOnBoardingView(viewModel: viewModel, commonViewViewModel: commonViewViewModel)
                        .environmentObject(authViewModel)
                case .isDeniedNoti:
                    RecomandPushNotificationView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                case .isLoginned:
                    CoreView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.firstUserPOPUP)
                        .environmentObject(authViewModel)
                        .environmentObject(sheetManager)
                }
            }
            .onAppear{
                authViewModel.getRefreshToken()
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
            .frame(height: UIScreen.screenHeight*0.05)
        
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
                    commonViewViewModel.viewPath.append(ViewState.isStartLogin)
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
                    commonViewViewModel.viewPath.append(ViewState.isStartEnter)
                }
            
            Spacer()
                .frame(height: 8)
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primaryOrange, style: .init(lineWidth: 2))
                .frame(height: 56)
                .overlay {
                    Text("둘러보기")
                        .foregroundStyle(Color.primaryOrangeText)
                        .pretendardFont(family: .SemiBold, size: 16)
                }
                .onTapGesture {
                    authViewModel.userid = ""
                    authViewModel.userEmail = ""
                    commonViewViewModel.isExploreApp = true
//                    commonViewViewModel.viewPath.append(ViewState.isLoginned)
                }
            
        }
        .padding(.horizontal, 20)
    }
}
