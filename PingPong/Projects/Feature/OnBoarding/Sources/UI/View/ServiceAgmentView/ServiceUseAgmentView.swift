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
    @ObservedObject private var i0 = Inject.observer
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var allAgreeCheckButton: Bool = false
    @State private var check14yearsAgreeButton: Bool = false
    @State private var checkTermsService: Bool = false
    @State private var checkPesonalInformation: Bool = false
    @State private var checkReciveMarketingInformation: Bool = false
    
    @State private var allConfirmAgreeView: Bool = false
    
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
            
            .navigationDestination(isPresented: $allConfirmAgreeView) {
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
                
                AgreeMentListView(checkAgreeButton: $allAgreeCheckButton, showleft: false, title: "약관 전체동의", showBold: true)
                    .onTapGesture {
                        allAgreeCheckButton = true
                        check14yearsAgreeButton = true
                        checkTermsService = true
                        checkPesonalInformation = true
                        checkReciveMarketingInformation = true
                    }
                
                Spacer()
                    .frame(height: 10)
                
                Rectangle()
                    .fill(.gray.opacity(0.6))
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 20)
                
                AgreeMentListView(checkAgreeButton: $check14yearsAgreeButton, showleft: false, title: "만 14세 이상입니다", showBold: false)
                
                
                AgreeMentListView(checkAgreeButton: $checkTermsService, showleft: true, title: "(필수) 서비스 이용약관", showBold: false)
                
                AgreeMentListView(checkAgreeButton: $checkPesonalInformation, showleft: true, title: "(필수) 개인정보 처리방침", showBold: false)
                
                AgreeMentListView(checkAgreeButton: $checkReciveMarketingInformation, showleft: true, title: "(필수) 마켓팅 정보 수신동의", showBold: false)
                
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
                            allConfirmAgreeView.toggle()
                        }
                }
                .opacity((allAgreeCheckButton && check14yearsAgreeButton && checkTermsService && checkPesonalInformation && checkReciveMarketingInformation) ? 1 : 0.5) // 버튼 활성화 조건 추가
                .disabled(!(allAgreeCheckButton && check14yearsAgreeButton && checkTermsService && checkPesonalInformation && checkReciveMarketingInformation)) // 버튼 비활성화 조건 추가
        }
    }
}

struct ServiceUseAgmentView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceUseAgmentView()
    }
}
