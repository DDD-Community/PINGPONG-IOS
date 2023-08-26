//
//  OnBoardingView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI
import Inject
import DesignSystem


public struct OnBoardingView: View {
    @State private var serviceUseAgmentView: Bool = false
    @ObservedObject private var i0 = Inject.observer
    
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
            
            .navigationDestination(isPresented: $serviceUseAgmentView) {
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
    //        private func loginWithGoogle() -> some View {
    //            Spacer()
    //                .frame(height: 20)
    //
    //            Button{
    ////                viewModel.googleLogin()
    //            } label: {
    //                HStack(spacing: 10) {
    //
    //                    Spacer()
    //
    //                    Image(asset: .googleLogo)
    //                        .resizable()
    //                        .frame(width: 20, height: 20)
    //                        .foregroundColor(Color.black)
    //
    //                    Text("구글 계정으로 계속하기")
    //
    //                    Spacer()
    //                }
    //            }
    //
    //            .frame(height: 50)
    //            .cornerRadius(10)
    //            .overlay(
    //                RoundedRectangle(cornerRadius: 10)
    //                    .stroke(Color.black, lineWidth: 1)
    //
    //            )
    //            .padding(.horizontal, 40)
    //        }
    @ViewBuilder
    private func loginWithApple() -> some View {
        Spacer()
            .frame(height: 20)
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 50)
            .foregroundColor(Color.black)
            .overlay(
                ZStack {
                    HStack(spacing: 10) {
                        Image(asset: .appleLogo)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding()
                        
                        Spacer()
                    }
                    
                    Text("Apple로 계속하기")
                        .foregroundColor(.white)
                        .bold()
                }
            )
            .padding(.horizontal, 30)
            .onTapGesture {
                
            }
    }
}


