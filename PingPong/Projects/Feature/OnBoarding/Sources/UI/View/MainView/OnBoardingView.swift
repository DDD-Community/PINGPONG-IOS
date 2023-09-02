//
//  OnBoardingView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI
import DesignSystem
import Authorization
import AuthenticationServices
//import GoogleSignIn
//import GoogleSignInSwift

public struct OnBoardingView: View {
    @StateObject var appState: OnBoardingAppState = OnBoardingAppState()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    
    public init() {
        //        self.i0 = i0
    }
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: UIScreen.screenHeight / 8)
                    
                    loadingAnimationView()
                    Text("명언제과점")
                        .bold()
                        .font(.custom("DNF Bit Bit TTF", size: 44))
                        .foregroundColor(.orange)
                    
                    cookeWiseSayingView()
                    //                    loginWithGoogle()
                    
                    socialLoginButtonView()
                    
                    
                    Spacer(minLength: .zero)
                }
            }
            .bounce(false)
            
            .navigationDestination(isPresented: $appState.serviceUseAgmentView) {
                ServiceUseAgmentView()
            }
        }
        
    }
    
    @ViewBuilder
    private func loadingAnimationView() -> some View {
        
        Spacer()
            .frame(height: UIScreen.screenWidth/7)
        
        Image(asset: .pingpongLogoOrange)
            .padding(.bottom, 16)
    }
    
    
    @ViewBuilder
    private func cookeWiseSayingView() -> some View {
        Spacer()
            .frame(height: UIScreen.screenWidth/7)
        
        VStack(alignment: .center) {
            Text("어제 보다 오늘 더 ")
            Text("맛있는 명언을 굽고 있어요")
        }
        .font(.system(size: 22))
    }
    
    @ViewBuilder
    private func socialLoginButtonView() -> some View {
        Spacer()
            .frame(height: UIScreen.screenWidth/7)
        
        VStack(spacing: .zero)  {
            //            GoogleSignInButton(action: handleSignInButton)
            Spacer()
                .frame(height: 12)
            
            loginWithApple()
            
        }
    }
    
//    @ViewBuilder
//    private func loginWithGoogle() -> some View {xzzzzz
//        Spacer()
//            .frame(height: 20)
//        
//        GoogleSignInButton(scheme: .light, style: .wide) {
//            authViewModel.googleLogin()
//        }
//        
//        
//    }
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
                
            case .failure(let error):
                break
            }
            
            
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 50)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        .padding(.horizontal, 40)
    }
}


