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
import PopupView

public struct OnBoardingView: View {
    @StateObject var appState: OnBoardingAppState = OnBoardingAppState()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    
    public init() {
        //        self.i0 = i0
    }
    public var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                   
                    
                    loadingAnimationView()
                    
                    cookeWiseSayingView()
                    //                    loginWithGoogle()
                    
                    socialLoginButtonView()
                    
                    
                    Spacer(minLength: .zero)
                }
            }
            .bounce(false)
            
            .navigationDestination(isPresented: $appState.serviceUseAgmentView) {
                ServiceUseAgreementView()
//                ServiceUseAgmentView()
            }
        }
        
        .popup(isPresented: $appState.signUPFaillPOPUP) {
            FloaterPOPUP(image: .errorCircle_rounded, floaterTitle: "알림", floaterSubTitle: "회원가입에 오류가 생겼습니다. 다시 시도해주세요")
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
            Image(asset: .backery)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.screenWidth/2, height: 400)
            
            Spacer()
        }
    }
    
    
    @ViewBuilder
    private func cookeWiseSayingView() -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            
            HStack {
                Spacer()
                    .frame(width: UIScreen.screenWidth*0.1 + 10)
                
                Text("명언제과점")
                    .gmarketSans(family: .Bold, size: 44)
                    .foregroundColor(.primaryOrange)
                Spacer()
            }
            
            Spacer()
                .frame(height: 12)
            
            HStack {
                Spacer()
                    .frame(width: UIScreen.screenWidth*0.1 + 10)
                
                
                Text("어제 보다 오늘 더 ")
                    .pretendardFont(family: .SemiBold, size: 18)
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 12)
            
            HStack {
                Spacer()
                    .frame(width: UIScreen.screenWidth*0.1 + 10)
                Text("맛있는 명언을 굽고 있어요")
                    .pretendardFont(family: .SemiBold, size: 18)
                
                Spacer()
            }
            
           
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
    }
}


