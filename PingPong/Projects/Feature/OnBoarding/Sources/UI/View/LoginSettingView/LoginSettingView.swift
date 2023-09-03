//
//  LoginSettingView.swift
//  OnBoarding
//
//  Created by Byeon jinha on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Authorization

public struct LoginSettingView: View {
    
    @StateObject private var viewModel: OnBoardingViewModel
       
       public init(viewModel: OnBoardingViewModel) {
           self._viewModel = StateObject(wrappedValue: viewModel)
       }
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @StateObject private var authviewModel: AuthorizationViewModel = AuthorizationViewModel()
    
    public var body: some View {
            ZStack (alignment: .bottom) {
                VStack {
                    topHeaderBackButton()
                    
                    loginSettingContentView()
                    
                    confirmButtonView()
                        .padding(.top, 62)
                    
                    Spacer()
                }
                
            }
            .navigationBarHidden(true)
            
            .navigationDestination(isPresented: $viewModel.allConfirmAgreeView) {
                LoginJobSettingView()
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
    private func loginSettingContentView() -> some View {
        Group {
            VStack{
                Spacer()
                    .frame(height: UIScreen.screenWidth*0.2 - 30)
                VStack {
                    HStack(spacing: 0) {
                        Text("명언제과점에서 사용할")
                        Spacer()
                    }
                    HStack(spacing: 0) {
                        Text("닉네임")
                            .foregroundColor(.primaryOrangeText)
                        Text("을 입력해주세요.")
                        Spacer()
                    }
                }
                .pretendardFont(family: .SemiBold, size: 24)
                .padding(.horizontal, 20)
                
                VStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(viewModel.validationColor, lineWidth: 1)
                        .frame(width: UIScreen.screenWidth - 40, height: 52)
                        .overlay(
                            ZStack {
                                TextField("닉네임을 입력해주세요.", text: $viewModel.nickname)
                                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 34))
                                    .onChange(of: viewModel.nickname, perform: { value in
                                        let nicknamdValidaion = viewModel.validateNickname(nickname: value)
                                        authviewModel.userNickNameValidateRequest(nickname: value)
                                        // 이부분에 중복 확인 코드 넣어주시면 됩니다. :)
                                        viewModel.allValidateNikname(nicknameValidate: nicknamdValidaion, duplicateValidate: authviewModel.nickNameInvalid)
                                    })
                                HStack {
                                    Spacer()
                                    Image(systemName: "x.circle.fill")
                                        .frame(width: 24, height: 24)
                                        .padding(.trailing, 10)
                                        .foregroundColor(.basicGray4)
                                        .onTapGesture {
                                            viewModel.nickname = ""
                                        }
                                }
                            }
                        )
                    HStack {
                        validateImageView(imageName: viewModel.validationImageName)
                        Text(viewModel.validationText)
                            .foregroundColor(viewModel.validationColor)
                            .pretendardFont(family: .Medium, size: 12)
                        Spacer()
                    }
                    .padding(.leading, 20)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 62, trailing: 0))
            }
        }
    }
    
    @ViewBuilder
    private func confirmButtonView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(viewModel.nicknameValidation == .valid ? .primaryOrange : .basicGray3)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("다음")
                        .foregroundColor(viewModel.nicknameValidation == .valid ? .basicWhite : .basicGray5)
                        .font(.system(size: 16))
                        .onTapGesture {
                            viewModel.allConfirmAgreeView.toggle()

                        }
                }
                .disabled(viewModel.nicknameValidation != .valid)
            
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




