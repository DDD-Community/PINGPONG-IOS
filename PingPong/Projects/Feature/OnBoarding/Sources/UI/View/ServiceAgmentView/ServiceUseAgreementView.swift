//
//  ServiceUseAgmentView.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/06/25.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import SwiftUI
import Inject
import DesignSystem
import SafariServices
import API
import Model

public struct ServiceUseAgreementView: View {
    public init(path: Binding<[ViewState]>) { self._path = path}
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: OnBoardingViewModel
    @EnvironmentObject var commonViewViewModel: CommonViewViewModel
    
    @Binding var path: [ViewState]
    
    public var body: some View {
        ZStack (alignment: .bottom) {
            VStack {
                topHeaderBackButton()
                
                serviceUseAgreeTextView()
                
                
                Spacer()
            }
            confirmButtonView()
                .padding(.bottom, 30)
            
        }
        .navigationBarHidden(true)
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
    private func serviceUseAgreeTextView() -> some View {
        Group {
            VStack{
                Spacer()
                    .frame(height: UIScreen.screenWidth*0.2 - 30)
                VStack {
                    HStack(spacing: 0) {
                        Text("서비스 이용 약관")
                            .foregroundColor(.primaryOrangeText)
                        Text("에")
                        Spacer()
                    }
                    HStack {
                        Text("동의해주세요.")
                        Spacer()
                    }
                }
                .pretendardFont(family: .SemiBold, size: 24)
                .padding(.horizontal, 20)
                
                
                AgreeMentListView(checkAgreeButton: $viewModel.allAgreeCheckButton,
                                  showleft: false,
                                  title: "전체 약관에 동의합니다",
                                  agreeAllService: true,
                                  essential: .essential, 
                                  safariURL: "", 
                                  webViewLoading: .constant(false))
                .onTapGesture {
                    viewModel.updateAgreementStatus()
                }
                
                Spacer()
                    .frame(height: 10)
                
                Spacer()
                    .frame(height: 20)
                
                AgreeMentListView(checkAgreeButton: $viewModel.checkTermsService,
                                  showleft: true,
                                  title: "서비스 이용약관 동의",
                                  agreeAllService: false,
                                  essential: .essential,
                                  safariURL: APIManger.shared.serviceAgreeMentURL,
                                  webViewLoading: $viewModel.checkServiceLoading
                )
                .onTapGesture {
                    viewModel.checkTermsService.toggle()
                    viewModel.allAgreeCheckButton = viewModel.checkAllAgreeStatus
                }
                
                AgreeMentListView(checkAgreeButton: $viewModel.checkPesonalInformation,
                                  showleft: true,
                                  title: "개인정보 수집 및 이용 동의",
                                  agreeAllService: false,
                                  essential: .essential,
                                  safariURL: APIManger.shared.privacyPolicyURL, 
                                  webViewLoading: $viewModel.checkServiceLoading
                )
                .onTapGesture {
                    viewModel.checkPesonalInformation.toggle()
                    viewModel.allAgreeCheckButton = viewModel.checkAllAgreeStatus
                }
                
                AgreeMentListView(checkAgreeButton: $viewModel.checkReciveMarketingInformation,
                                  showleft: true,
                                  title: "마케팅 정보 수신동의",
                                  agreeAllService: false,
                                  essential: .choice,
                                  safariURL: APIManger.shared.marketAgreeMentURL,
                                  webViewLoading: $viewModel.checkServiceLoading
                )
                .onTapGesture {
                    viewModel.checkReciveMarketingInformation.toggle()
                    viewModel.allAgreeCheckButton = viewModel.checkAllAgreeStatus
                }
            }
        }
    }
    
    @ViewBuilder
    private func confirmButtonView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor( viewModel.checkAgreementStatus ? .primaryOrange : .basicGray3)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("다음")
                        .foregroundColor(viewModel.checkAgreementStatus ? .basicWhite : .basicGray5)
                        .font(.system(size: 16))
                        .onTapGesture {
                            commonViewViewModel.viewPath.append(ViewState.isServiceAgreeComplete)
                        }
                }
                .disabled(!(viewModel.checkAgreementStatus)) // 버튼 비활성화 조건 추가
        }
    }
}
