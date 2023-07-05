//
//  ServiceUseAgmentView.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/06/25.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Inject
import DesignSystem

struct ServiceUseAgmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel: OnBoardingViewModel = OnBoardingViewModel()
        
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom) {
                VStack {
                    topHeaderBackButton()
                    
                    serviceUseAgreeTextView()
                    
                    
                    Spacer()
                }
                
                confirmButtonView()
                
                
            }
            .navigationBarHidden(true)
            
            .navigationDestination(isPresented: $viewModel.allConfirmAgreeView) {
                ConfrimallAgmentView()
            }
        }
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        Spacer()
            .frame(height: 20)
        
        HStack {
            Image(systemName: "arrow.left")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.gray)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            Spacer()
            
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func serviceUseAgreeTextView() -> some View {
        Group {
            VStack{
                Spacer()
                    .frame(height: UIScreen.screenWidth*0.2 - 30)
                
                HStack {
                    Text("서비스 이용 동의")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                AgreeMentListView(checkAgreeButton: $viewModel.allAgreeCheckButton, showleft: false, title: "약관 전체동의", showBold: true)
                    .onTapGesture {
                        viewModel.updateAgreementStatus()
                    }
                
                Spacer()
                    .frame(height: 10)
                
                Rectangle()
                    .fill(.gray.opacity(0.6))
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 20)
                
                AgreeMentListView(checkAgreeButton: $viewModel.check14yearsAgreeButton, showleft: false, title: "만 14세 이상입니다", showBold: false)
                    .onTapGesture {
                        viewModel.check14yearsAgreeButton.toggle()
                        viewModel.allAgreeCheckButton = viewModel.check14yearsAgreeButton && viewModel.checkTermsService && viewModel.checkPesonalInformation && viewModel.checkReciveMarketingInformation
                    }
                
                AgreeMentListView(checkAgreeButton: $viewModel.checkTermsService, showleft: true, title: "(필수) 서비스 이용약관", showBold: false)
                    .onTapGesture {
                        viewModel.checkTermsService.toggle()
                        viewModel.allAgreeCheckButton = viewModel.check14yearsAgreeButton && viewModel.checkTermsService && viewModel.checkPesonalInformation && viewModel.checkReciveMarketingInformation
                    }
                
                AgreeMentListView(checkAgreeButton: $viewModel.checkPesonalInformation, showleft: true, title: "(필수) 개인정보 처리방침", showBold: false)
                    .onTapGesture {
                        viewModel.checkPesonalInformation.toggle()
                        viewModel.allAgreeCheckButton = viewModel.check14yearsAgreeButton && viewModel.checkTermsService && viewModel.checkPesonalInformation && viewModel.checkReciveMarketingInformation
                    }
                
                AgreeMentListView(checkAgreeButton: $viewModel.checkReciveMarketingInformation, showleft: true, title: "(필수) 마켓팅 정보 수신동의", showBold: false)
                    .onTapGesture {
                        viewModel.checkReciveMarketingInformation.toggle()
                        viewModel.allAgreeCheckButton = viewModel.check14yearsAgreeButton && viewModel.checkTermsService && viewModel.checkPesonalInformation && viewModel.checkReciveMarketingInformation
                    }
                
            }
        }
    }
    
    @ViewBuilder
    private func confirmButtonView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.8), style: .init(lineWidth: 1))
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .shadow(color: Color.gray, radius: 20)
                .overlay {
                    Text("확인")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .onTapGesture {
                            viewModel.allConfirmAgreeView.toggle()
                        }
                }
                .opacity((viewModel.allAgreeCheckButton && viewModel.check14yearsAgreeButton && viewModel.checkTermsService && viewModel.checkPesonalInformation && viewModel.checkReciveMarketingInformation) ? 1 : 0.5) // 버튼 활성화 조건 추가
                .disabled(!(viewModel.allAgreeCheckButton && viewModel.check14yearsAgreeButton && viewModel.checkTermsService && viewModel.checkPesonalInformation && viewModel.checkReciveMarketingInformation)) // 버튼 비활성화 조건 추가
        }
    }
}

struct ServiceUseAgmentView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceUseAgmentView()
    }
}
