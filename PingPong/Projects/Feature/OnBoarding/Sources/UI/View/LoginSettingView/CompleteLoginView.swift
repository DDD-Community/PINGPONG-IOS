//
//  CompleteLoginView.swift
//  OnBoarding
//
//  Created by Byeon jinha on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//


import DesignSystem
import SwiftUI
import Authorization

public struct CompleteLoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @StateObject private var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    public init() { }
    public var body: some View {
            ZStack (alignment: .bottom) {
                VStack {
                    topHeaderBackButton()
                    
                    completeLoginContentView()
                    
                    Spacer()
                    confirmButtonView()
                        .padding(.bottom, 30)
                }
                
            }
            .navigationBarHidden(true)
            
            .navigationDestination(isPresented: $viewModel.allConfirmAgreeView) {
                //회원가입 완료 후 보낼 뷰를 넣어주세요 :)
            }
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        Spacer()
            .frame(height: 20)
        
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 18)
                .foregroundColor(.gray)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func completeLoginContentView() -> some View {
        Group {
            VStack{
                Spacer()
                    .frame(height: UIScreen.screenWidth*0.2 - 30)
                HStack {
                    Text("가입 완료")
                        .pretendardFont(family: .SemiBold, size: 18)
                        .foregroundColor(.primaryOrangeText)
                    Spacer()
                }
                VStack {
                    HStack(spacing: 0) {
                        Text("명언제과점의")
                        Spacer()
                    }
                    HStack(spacing: 0) {
                        Text("제빵사가 되신 것을 축하합니다!")
                        Spacer()
                    }
                }
                .pretendardFont(family: .SemiBold, size: 24)
                .padding(.top, 8)
               
                
                HStack {
                    Text("이제 나만의 명언을 구워볼까요?")
                        .pretendardFont(family: .Medium, size: 18)
                        .foregroundColor(.basicGray6)
                    Spacer()
                }
                .padding(.top, 10)
                Image(assetName: "completeLoginImage")
                
            } .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private func confirmButtonView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.primaryOrange)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("가입 완료")
                        .foregroundColor(.basicWhite)
                        .font(.system(size: 16))
                        .onTapGesture {
                            authViewModel.signupPost(uid: authViewModel.uid, fcm: AppManager.shared.fcmToken, email: authViewModel.userEmail, nickname: viewModel.nickname, jobCd: String(viewModel.selectJobCode)) {
                                authViewModel.isLogin = true
//                                authViewModel.completdSignUP = true
                                viewModel.allConfirmAgreeView.toggle()
                            }
                        }
                }
                .disabled(viewModel.selectedJob != nil)
        }
    }
    
    @ViewBuilder
    private func validateImageView(imageName: String?) -> some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(viewModel.validationColor)
            }
            EmptyView()
        }
    }
}
