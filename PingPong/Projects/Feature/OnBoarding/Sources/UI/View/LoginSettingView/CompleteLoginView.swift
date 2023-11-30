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
import PopupView

public struct CompleteLoginView: View {
    @StateObject private var viewModel: OnBoardingViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
       public init(viewModel: OnBoardingViewModel) {
           self._viewModel = StateObject(wrappedValue: viewModel)
       }
    
    
    
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
        
            .popup(isPresented: $authViewModel.isSignupFail) {
                FloaterPOPUP(image: .errorCircle_rounded, floaterTitle: "알림", floaterSubTitle: "회원가입에 실패하였습니다. 다시 시도해주세요")
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
                            viewModel.viewPath.append(ViewState.isCompleteLogin)
                            //MARK: - 임시로  하드 코딩 나중에 로그인 성공하면  success action에  추가
                            //TODO: 회원가입 중간에 나가면 뷰깨지는 문제 해결
                            viewModel.completdSignUP = true
                            authViewModel.signupPost(token: authViewModel.uid, fcm: AppManager.shared.fcmToken, email: authViewModel.userEmail, nickname: viewModel.nickname, jobCd: String(viewModel.selectJobCode)) {
                                
                            } failSignUPAction: {
//                                authViewModel.isSignupFail.toggle()
                            }
                        }
                }
                .disabled(viewModel.selectedJob == nil)
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
