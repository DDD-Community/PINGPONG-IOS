//
//  OtherSettingView.swift
//  Profile
//
//  Created by 서원지 on 11/8/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem
import Model
import Authorization
import API

public struct OtherSettingView: View {
    @StateObject private var appState: AppState
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject private var profileViewModel: ProfileViewViewModel = ProfileViewViewModel()
    @EnvironmentObject var authViewModel: AuthorizationViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    public init(viewModel: CommonViewViewModel, appState: AppState) {
        self._appState = StateObject(wrappedValue: appState)
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            Color.basicGray2
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                topHeaderBackButton()
                
                otherSettingList()
                
                Spacer()
                
            }
        }
        
        .navigationDestination(isPresented: $profileViewModel.gotoPrivacyPolicyView) {
            WebViews(
                url: APIManger.shared.privacyPolicyURL ,
                loading: $profileViewModel.loadingWebView
            )
            .navigationBarBackButtonHidden()
        }
        
        .navigationDestination(isPresented: $profileViewModel.gotoTermsOfServiceView) {
            WebViews(
                url: APIManger.shared.serviceAgreeMentURL,
                loading: $profileViewModel.loadingWebView
            )
            .navigationBarBackButtonHidden()
        }
        
        .navigationDestination(isPresented: $profileViewModel.gotoWithDrawView) {
            WithDrawView(authViewModel: authViewModel, viewModel: viewModel)
                .navigationBarBackButtonHidden()
        }
    }
    
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        Spacer()
            .frame(height: 16)
        
        HStack {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 18)
                    .foregroundColor(.basicGray8)
                
                Text("기타 설정")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(.basicBlack)
            }
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
            
            
            Spacer()
        }
        .padding(.horizontal, 20)
        
        Spacer()
            .frame(height: 16)
    }
    
    @ViewBuilder
    private func otherSettingList() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.basicWhite)
            .frame(height: UIScreen.screenHeight*0.3)
            .padding(.horizontal, 20)
            .overlay {
                VStack {
                    ForEach(OhterSettingItem.allCases, id: \.self){ item in
                        listItemView(showArrow: item != .appVersion ? true : false, showLine: item == .privacyPolicy || item == .withDraw  || item == .termsOfService ? true : false , text: item.description, versionText: item == .appVersion ? "v.\(profileViewModel.appVersion )": "") {
                            switch item  {
                                
                            case .privacyPolicy:
                                profileViewModel.gotoPrivacyPolicyView.toggle()
                            case .termsOfService:
                                profileViewModel.gotoTermsOfServiceView.toggle()
                            case .withDraw:
                                profileViewModel.gotoWithDrawView.toggle()
                            case .appVersion:
                                break
                            }
                            
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        
    }
    
    @ViewBuilder
    private func listItemView(showArrow: Bool, showLine: Bool, text: String, versionText: String ,goToDeatilView: @escaping () -> Void) -> some View {
        VStack(spacing: .zero) {
            Spacer()
                .frame(height: 20)
            
            HStack(spacing: .zero) {
                Text(text)
                    .foregroundColor(Color.basicGray9)
                    .pretendardFont(family: .Medium, size: 16)
                
                Spacer()
                
                if showArrow {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 6, height: 12)
                    
                }
                else {
                    Text(versionText)
                        .foregroundColor(Color.basicGray9)
                        .pretendardFont(family: .Medium, size: 14)
                }
                
            }
            .onTapGesture {
                if showArrow {
                    goToDeatilView()
                }
            }
            
            Spacer()
                .frame(height: 20)
            
            if showLine {
                Rectangle()
                    .fill(Color.basicGray4)
                    .frame(height: 1)
            }
        }
        .padding(.horizontal, 16)
        
    }
}

