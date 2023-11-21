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
import PopupView

public struct ProfileView: View {
    @StateObject private var appState: AppState
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject private var profileViewModel: ProfileViewViewModel = ProfileViewViewModel()
    @ObservedObject var authViewModel: AuthorizationViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var backAction: () -> Void
    
    public init(
        viewModel: CommonViewViewModel,
        appState: AppState,
        backAction: @escaping () -> Void,
        authViewModel: AuthorizationViewModel
        
    ) {
        self._appState = StateObject(wrappedValue: appState)
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
        self._authViewModel = ObservedObject(wrappedValue: authViewModel)
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
                    userProfileList()
                    
                    userManagementList()

                    appManagementList()
                    
                    logoutButton()
                }
                
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        
        .task {
            authViewModel.searchUserIdRequest(uid: "\(authViewModel.userid)")
            
            if profileViewModel.randomNickName == "" {
                await profileViewModel.randomNameRequest(commCdTpCd: .userDesc)
            }
            
            
            print("\(profileViewModel.randomNickName)")
        }
        
        .navigationDestination(isPresented: $profileViewModel.gotoOtherSettingView) {
            OtherSettingView(viewModel: viewModel, appState: appState)
                .environmentObject(appState)
                .environmentObject(authViewModel)
                .navigationBarBackButtonHidden()
        }
        
        .navigationDestination(isPresented: $profileViewModel.gotoNotificationQuoteView) {
            NotificationQuoteView(authViewModel: authViewModel)
                .navigationBarBackButtonHidden()
        }
        
        .sheet(isPresented: $profileViewModel.changeNickNameView, content: {
            ChangeNickNameView(viewModel: profileViewModel, authViewModel: authViewModel) {
                profileViewModel.changeNickNameView = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    profileViewModel.changeNickNameSuccessPOPUP.toggle()
                }
            }
            .presentationDetents([UIScreen.main.bounds.height.native == 667 ? .height(UIScreen.screenHeight/2 + UIScreen.screenWidth*0.2) : .height(UIScreen.screenHeight/3 + UIScreen.screenWidth*0.2)])
            .presentationCornerRadius(20)
        })
        
        .popup(isPresented: $profileViewModel.changeNickNameSuccessPOPUP) {
            WithDrawPOPUP(
                image: .empty,
                title: "성공",
                subTitle: "닉네임이 변경이 되었습니다",
                confirmAction: {},
                cancelAction: {
                    profileViewModel.changeNickNameSuccessPOPUP = false
                },
                noImage: true,
                noImageButton: true)
        } customize: { popup in
            popup
                .type(.default)
                .position(.bottom)
                .animation(.easeIn)
                .closeOnTap(true)
                .closeOnTapOutside(true)
                .backgroundColor(.basicBlackDimmed)
        
        }
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        HStack {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 18)
                    .foregroundColor(.basicGray8)
                   
                Text("설정")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(.basicBlack)
            }
            .onTapGesture {
                backAction()
            }
            
            
            Spacer()
        }
        .frame(height: 40)
        .padding(EdgeInsets(top: 60, leading: 20, bottom: 0, trailing: 20))
    }
    
    @ViewBuilder
    private func userProfileList() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.basicWhite)
            .frame(height: 80)
            .padding(.horizontal, 20)
            .overlay {
                VStack {
                    HStack(spacing: .zero) {
                        Spacer()
                            .frame(width: 16)
                        
                        Circle()
                            .frame(width: 57, height: 57)
                            .foregroundColor(.sweetFilter)
                        
                        Spacer()
                            .frame(width: 16)
                        
                        VStack(spacing: .zero) {
                            HStack {
                                Text("\(authViewModel.signupModel?.data?.nickname ?? "")")
                                    .pretendardFont(family: .SemiBold, size: 18)
                                    .foregroundColor(Color.basicGray9)
                                Spacer()
                                
                            }
                            
                            HStack {
                                Text(profileViewModel.randomNickName)
                                    .pretendardFont(family: .Medium, size: 14)
                                    .foregroundColor(Color.basicGray7)
                                
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        Image(assetName: "editImage")
                            .frame(width: 24.62, height: 24)
                            .onTapGesture {
                                profileViewModel.changeNickNameView.toggle()
                            }
                        
                        Spacer()
                            .frame(width: 16)
                    }
                }
                .padding(.horizontal, 16)
            }
            
        
    }
    
    @ViewBuilder
    private func userManagementList() -> some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.basicWhite)
            .frame(height: 158)
            .overlay(
                VStack {
                    HStack {
                        Text("명언 취향 관리")
                            .pretendardFont(family: .SemiBold, size: 16)
                            .foregroundColor(.basicGray8)
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 12, trailing: 0))
                        Spacer()
                        Image(assetName: "editImage")
                            .frame(width: 24.62, height: 24)
                            .padding(.trailing, 16)
                    }
                    .frame(width: UIScreen.screenWidth - 40, height: 52)
                    
                    HStack {
                        Text("명언 유형")
                            .pretendardFont(family: .Medium, size: 14)
                            .foregroundColor(.basicGray7)
                            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 0))
                        Spacer()
                        HStack{
                            HStack {
                                Image(assetName: viewModel.selectedCard.hashtags.flavor.type.smallIconImageName)
                                Text(viewModel.selectedCard.hashtags.flavor.type.korean)
                                    .pretendardFont(family: .SemiBold, size: 12)
                            }
                            .foregroundColor(.mildIconText)
                            .frame(minWidth: 41, maxHeight: 26)
                            .padding(.horizontal, 10)
                            .background (
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(.basicGray1BG)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.basicGray3)
                                    )
                            )
                            
                            HStack {
                                Image(assetName: viewModel.selectedCard.hashtags.source.type.smallIconImageName)
                                Text(viewModel.selectedCard.hashtags.source.type.korean)
                                    .pretendardFont(family: .SemiBold, size: 12)
                                    .foregroundColor(.animation)
                            }
                            .frame(minWidth: 41, maxHeight: 26)
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(.basicGray1BG)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.basicGray3)
                                    )
                            )
                        }
                        .padding(.trailing, 16)
                    }
                    .frame(width: UIScreen.screenWidth - 40, height: 42)
                    
                    HStack {
                        Text("명언 성향")
                            .pretendardFont(family: .Medium, size: 14)
                            .foregroundColor(.basicGray7)
                            .padding(EdgeInsets(top: 10, leading: 16, bottom: 18, trailing: 0))
                        
                        Spacer()
                        HStack{
                            HStack {
                                Image(assetName: viewModel.selectedCard.hashtags.flavor.type.smallIconImageName)
                                Text(viewModel.selectedCard.hashtags.flavor.type.korean)
                                    .pretendardFont(family: .SemiBold, size: 12)
                            }
                            .foregroundColor(.mildIconText)
                            .frame(minWidth: 41, maxHeight: 26)
                            .padding(.horizontal, 10)
                            .background (
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(.basicGray1BG)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.basicGray3)
                                    )
                            )
                            
                            HStack {
                                Image(assetName: viewModel.selectedCard.hashtags.source.type.smallIconImageName)
                                Text(viewModel.selectedCard.hashtags.source.type.korean)
                                    .pretendardFont(family: .SemiBold, size: 12)
                                    .foregroundColor(.animation)
                            }
                            .frame(minWidth: 41, maxHeight: 26)
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(.basicGray1BG)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.basicGray3)
                                    )
                            )
                        }
                        .padding(.trailing, 16)
                    }
                    .frame(width: UIScreen.screenWidth - 40, height: 50)
                }
            )
            .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
    }
    
    @ViewBuilder
    private func appManagementList() -> some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.basicWhite)
            .frame(height: 336)
            .overlay {
                VStack {
                    ForEach(profileViewModel.profileViewListArray) { profileViewComponent in
                        HStack {
                            Image(assetName: profileViewComponent.imageName)
                                .resizable()
                                .frame(width: 40,height: 40)
                                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 10))
                            VStack(alignment: .leading) {
                                Text(profileViewComponent.content)
                                    .pretendardFont(family: .Medium, size: 16)
                                    .foregroundColor(.basicGray8)
                                Spacer()
                                    .frame(height: 2)
                                Text(profileViewComponent.detail)
                                    .pretendardFont(family: .Regular, size: 12)
                                    .foregroundColor(.basicGray6)
                            }
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                                .padding(.trailing, 25)
                        }
                        .onTapGesture {
                            switch profileViewComponent.imageName {
                            case "notificationImage":
                                profileViewModel.gotoNotificationQuoteView.toggle()
                                
                            case "reviewImage":
//                                if let reviewURL = URL(string: "itms-apps://itunes.apple.com/app/itunes-u/id\()?ls=1&mt=8&action=write-review"), UIApplication.shared.canOpenURL(reviewURL) { // 유효한 URL인지 검사합니다.
//                                    if #available(iOS 10.0, *) { //iOS 10.0부터 URL를 오픈하는 방법이 변경 되었습니다.
//                                        UIApplication.shared.open(reviewURL, options: [:], completionHandler: nil)
//                                    } else {
//                                        UIApplication.shared.openURL(reviewURL)
//                                    }
//                                }
                                break
                            case "settingImage":
                                profileViewModel.gotoOtherSettingView.toggle()
                                
                            case "bugImage":
                                guard let url = URL(string: "mailto:suhwj81@gmail.com") else {
                                    return
                                }
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            default:
                                break
                            }
                        }
                        if profileViewComponent.isDevider {
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width - 80, height: 1)
                                .foregroundColor(.basicGray4)
                        }
                    }
                    
                }
                
            }
            .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
    }
    
    @ViewBuilder
    private func logoutButton() -> some View {
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
                authViewModel.isLoginCheck = false
                presentationMode.wrappedValue.dismiss()
                
            }
    }
}
