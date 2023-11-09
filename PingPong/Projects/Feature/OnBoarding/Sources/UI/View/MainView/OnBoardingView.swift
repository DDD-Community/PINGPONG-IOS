//
//  OnBoardingView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import Common
import SwiftUI
import DesignSystem
import Authorization
import AuthenticationServices
import PopupView
import Home
import Core
//import GoogleSignInSwift

public struct OnBoardingView: View {
    @StateObject var appState: OnBoardingAppState = OnBoardingAppState()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    @StateObject var viewModel: OnBoardingViewModel
    @StateObject var commonViewViewModel: CommonViewViewModel = CommonViewViewModel()
    @StateObject var sheetManager: SheetManager  = SheetManager()
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isSignUP: Bool
    @Binding var loginWithEmail: Bool
    
    public init(
        viewModel: OnBoardingViewModel,
        isSignUP: Binding<Bool>,
        loginWithEmail: Binding<Bool>
    
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._isSignUP = isSignUP
        self._loginWithEmail = loginWithEmail
    }
    public var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
               
                loadingAnimationView()
                
                cookeWiseSayingView()
                
                socialLoginButtonView()
                
                
            }
            
            .navigationDestination(isPresented: $appState.serviceUseAgmentView) {
                ServiceUseAgreementView()
                    .environmentObject(viewModel)
            }
            
//            .fullScreenCover(isPresented: $appState.goToMainHomeView, content: {
//                CoreView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.isFirstUserPOPUP)
//                    .environmentObject(sheetManager)
//                    .navigationBarHidden(true)
//            })
            
            .navigationDestination(isPresented: $appState.goToMainHomeView) {
                CoreView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.isFirstUserPOPUP)
                    .environmentObject(sheetManager)
                    .environmentObject(authViewModel)
            }
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
       //mark:
        
        
        
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if viewModel.completdSignUP {
                        appState.goToMainHomeView.toggle()
                        authViewModel.isLogin = true
                    } else if loginWithEmail {
                        //MARK: - 이미 회원가입 한 사람이고  차후에  로그인  api  태우기
                        Task {
                            await authViewModel.loginWithEmail(
                                email: authViewModel.userEmail, 
                                succesCompletion: {
                                    appState.goToMainHomeView.toggle()
                                    authViewModel.isLogin = true
                                }, failLoginCompletion:  {
                                    appState.signUPFaillPOPUP.toggle()
                                    
                                    presentationMode.wrappedValue.dismiss()
                                })
                        }
                    } else if isSignUP{
                        appState.serviceUseAgmentView.toggle()
                    }
                }
                
            case .failure(let error):
                appState.signUPFaillPOPUP.toggle()
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


