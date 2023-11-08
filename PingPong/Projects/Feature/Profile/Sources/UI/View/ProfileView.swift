//
//  ProfileView.swift
//  ChaeviUS
//
//  Created by 서원지 on 2023/11/05
//  Copyright © 2023 DaeYoung Chaevi. co., Ltd. All rights reserved.
//

import Common
import DesignSystem
import Model
import Authorization
import SwiftUI

public struct ProfileView: View {
    @StateObject private var appState: AppState
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject private var profileViewModel: ProfileViewViewModel = ProfileViewViewModel()
    @EnvironmentObject var authViewModel: AuthorizationViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @State var gotoOtherSettingView: Bool = false
    
    var backAction: () -> Void
    
    public init(viewModel: CommonViewViewModel, appState: AppState, backAction: @escaping () -> Void) {
        self._appState = StateObject(wrappedValue: appState)
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
    }
    
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    public var body: some View {
        ZStack {
            Color.basicGray2
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                topHeaderBackButton()
                
                Spacer()
                ScrollView {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.basicWhite)
                        .frame(height: 80)
                        .overlay {
                            VStack {
                                HStack {
                                    Circle()
                                        .frame(width: 57, height: 57)
                                        .foregroundColor(.sweetFilter)
                                    Text("임닉네임니니니아미801")
                                        .pretendardFont(family: .SemiBold, size: 18)
                                }
                            }
                        }
                        .onTapGesture {
                            gotoOtherSettingView.toggle()
                        }
                        .padding(EdgeInsets(top: 22, leading: 20, bottom: 0, trailing: 20))
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.basicWhite)
                        .frame(height: 148)
                        .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
                    //                .overlay {
                    //                }
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.basicWhite)
                        .frame(height: 336)
                        .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
                                    .overlay {
                                        
                                        Rectangle()
                                            .frame(width: UIScreen.main.bounds.width - 80, height: 1)
                                            .foregroundColor(.basicGray4)
                                        Rectangle()
                                            .frame(width: UIScreen.main.bounds.width - 80, height: 1)
                                            .foregroundColor(.basicGray4)
                                        Rectangle()
                                            .frame(width: UIScreen.main.bounds.width - 80, height: 1)
                                            .foregroundColor(.basicGray4)
                                        
                                    }
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.logoutBorder, style: .init(lineWidth: 2))
                    //                .fill(Color.basicWhite)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
                        .overlay {
                            Text("로그아웃")
                                .pretendardFont(family: .Medium, size: 14)
                                .foregroundColor(.logoutText)
                        }
                        .onTapGesture {
                            authViewModel.isLogin = false
                        }
                }
                
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        
        .navigationDestination(isPresented: $gotoOtherSettingView) {
            OtherSettingView(viewModel: viewModel, appState: appState)
                .environmentObject(appState)
                .environmentObject(authViewModel)
                .navigationBarBackButtonHidden()
        }
    }
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 18)
                .foregroundColor(.basicGray8)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Text("설정")
                .pretendardFont(family: .SemiBold, size: 18)
                .foregroundColor(.basicBlack)
            Spacer()
        }
        .frame(height: 40)
        .padding(EdgeInsets(top: 60, leading: 20, bottom: 0, trailing: 20))
    }
    
    
}
