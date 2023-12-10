//
//  OnBoardingLoginView.swift
//  OnBoarding
//
//  Created by 서원지 on 11/19/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import SwiftUI
import DesignSystem
import Authorization
import AuthenticationServices
import Home
import Core
import Model

public struct OnBoardingLoginView: View {
    @StateObject var appState: OnBoardingAppState = OnBoardingAppState()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    @ObservedObject var viewModel: OnBoardingViewModel
    @StateObject var commonViewViewModel: CommonViewViewModel
    @StateObject var sheetManager: SheetManager  = SheetManager()
    
    @Environment(\.presentationMode) var presentationMode
    
    public init(
        viewModel: OnBoardingViewModel,
        commonViewViewModel: CommonViewViewModel
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self._commonViewViewModel = StateObject(wrappedValue: commonViewViewModel)
    }
    
    public var body: some View {
            VStack(spacing: .zero) {
               
                loadingAnimationView()
                
                cookeWiseSayingView()
                
                socialLoginButtonView()
            
        }
        
        .popup(isPresented: $appState.signUPFaillPOPUP) {
            FloaterPOPUP(image: .errorCircle_rounded, floaterTitle: "알림", floaterSubTitle: "애플로그인에 오류가 생겼습니다. 다시 시도해주세요")
        } customize: { popup in
            popup
                .type(.floater(verticalPadding: 10))
                .position(.top)
                .animation(.easeIn)
                .closeOnTap(true)
                .closeOnTapOutside(true)
            
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
    private func cookeWiseSayingView() -> some View {
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
    private func socialLoginButtonView() -> some View {
        Spacer()
            .frame(height: UIScreen.screenWidth/7)
        
        VStack(spacing: .zero)  {
            Spacer()
                .frame(height: 12)
            
            loginWithApple()
            
        }
    }

    @ViewBuilder
    private func loginWithApple() -> some View {
        Spacer()
            .frame(height: 20)
        
        SignInWithAppleButton(.signIn) { request in
            authViewModel.nonce = AppleLoginManger.shared.randomNonceString()
            request.requestedScopes = [.fullName, .email]
            request.nonce =  AppleLoginManger.shared.sha256(authViewModel.nonce)
        } onCompletion: { result in
            switch result {
            case .success(let authResult):
                guard let credential =  authResult.credential as?
                        ASAuthorizationAppleIDCredential  else  {
                    debugPrint("파이어 베이스 로그인 에러 ")
                    return
                }
                authViewModel.appleLogin(credential: credential)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    Task {
                        await authViewModel.loginWithEmail(
                            email: authViewModel.userEmail,
                            succesCompletion: { model in
                                commonViewViewModel.isLogin = true
                                commonViewViewModel.isLoginCheck = true
                                authViewModel.userid = model.data?.id ?? .zero
                                authViewModel.userNickName = model.data?.nickname ?? ""
                                commonViewViewModel.isLoginExplore = false
                            }, failLoginCompletion:  {
                                appState.signUPFaillPOPUP.toggle()
                                presentationMode.wrappedValue.dismiss()
                            })
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    appState.signUPFaillPOPUP.toggle()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 50)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
        )
        .padding(.horizontal, 40)
        
        Spacer()
            .frame(height: 48)
    }
}


