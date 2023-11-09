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
    
    public init(viewModel: OnBoardingViewModel){
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
               
                loadingAnimationView()
                
                cookeWiseSayingView()
                
                authButton()
                
            }
            
            .navigationDestination(isPresented: $viewModel.goToLoginView) {
                OnBoardingView(viewModel: viewModel,
                               isSignUP: $viewModel.isSignUP,
                               loginWithEmail: $viewModel.alreadySignUP)
                    .navigationBarBackButtonHidden()
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
                    viewModel.goToLoginView = true
                    viewModel.alreadySignUP = true
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
                    viewModel.goToLoginView = true
                    viewModel.isSignUP = true
                    viewModel.alreadySignUP = false
                }
            
            
        }
        .padding(.horizontal, 20)
    }
}

