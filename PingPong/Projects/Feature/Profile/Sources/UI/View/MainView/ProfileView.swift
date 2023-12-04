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
    @StateObject var authViewModel: AuthorizationViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sheetManager: SheetManager
    
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
        self._authViewModel = StateObject(wrappedValue: authViewModel)
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
            Rectangle()
                .foregroundColor(sheetManager.isPopup ? Color.basicBlackDimmed : .clear)
        }
        .profileModal(with: sheetManager, viewModel: viewModel)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        
        .task {
            if authViewModel.randomAuthNickName == "" {
                await authViewModel.randomNameRequest(commCdTpCd: .userDesc, completion: { model  in
                    authViewModel.randomAuthNickName = model.data?.commCds.randomElement()?.commNm ?? ""
                    profileViewModel.changeImage(randomNickName: authViewModel.randomAuthNickName)
                })
            }
            profileViewModel.changeImage(randomNickName: authViewModel.randomAuthNickName)
            
           await authViewModel.loginWithEmail(email: authViewModel.userEmail, succesCompletion: { model in
               authViewModel.userNickName = model.data?.nickname ?? ""
               authViewModel.userid = model.data?.id ?? .zero
           }, failLoginCompletion: {})
           
            authViewModel.searchUserIdRequest(uid: "\(authViewModel.userid)")
            
            await profileViewModel.profileUserPrefRequset(userid: "\(authViewModel.userid)", completion: { _ in
                for userFlavor in profileViewModel.profileUserPrefModel?.data?.flavors ?? [] {
                    guard let flavor = Flavor(rawValue: userFlavor) else { continue }
                    if !viewModel.selectedFlavorArray.contains(flavor) {
                        viewModel.selectedFlavorArray.append(flavor)
                    }
                }
                for userSource in profileViewModel.profileUserPrefModel?.data?.sources ?? [] {
                    guard let source = Source(rawValue: userSource) else { continue }
                    if !viewModel.selectedSourceArray.contains(source) {
                        viewModel.selectedSourceArray.append(source)
                    }
                }
            })
            
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
            .ignoresSafeArea(.keyboard)
            .presentationDetents([UIScreen.main.bounds.height.native == 667 ? .height(UIScreen.screenHeight/2 + UIScreen.screenWidth*0.7) : .height(UIScreen.screenHeight/3 + UIScreen.screenWidth*0.7)])
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
                viewModel.coreViewPath.removeLast()
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
                            .overlay {
                                Image(assetName: profileViewModel.changeNickImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 57, height: 57)
                            }
                        
                        Spacer()
                            .frame(width: 16)
                        
                        VStack(spacing: .zero) {
                            HStack {
                                Text(authViewModel.userNickName)
                                    .pretendardFont(family: .SemiBold, size: 18)
                                    .foregroundColor(Color.basicGray9)
                                Spacer()
                                
                            }
                            
                            HStack {
                                Text(authViewModel.randomAuthNickName)
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
                    }
                    .frame(width: UIScreen.screenWidth - 40, height: 52)
                    
                    HStack {
                        Text("명언 유형")
                            .pretendardFont(family: .Medium, size: 14)
                            .foregroundColor(.basicGray7)
                            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 0))
                        Spacer()
                        
                        if viewModel.selectedSourceArray.count > 2 || viewModel.selectedSourceArray.count == 0{
                            HStack{
                                HStack {
                                    Text("유형 전체")
                                        .pretendardFont(family: .SemiBold, size: 12)
                                }
                                .foregroundColor(.basicGray7)
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
                                .onTapGesture {
                                    withAnimation {
                                        sheetManager.present(with: .init(idx: 0))
                                        sheetManager.isPopup = true
                                    }
                                }
                                .padding(.trailing, 16)
                                
                            }
                        } else {
                            ForEach(viewModel.selectedSourceArray, id: \.self) { source in
                                
                                HStack{
                                    HStack {
                                        Image(assetName: source.type.smallIconImageName)
                                        Text(source.type.korean)
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
                                    .onTapGesture {
                                        withAnimation {
                                            sheetManager.present(with: .init(idx: 0))
                                            sheetManager.isPopup = true
                                        }
                                    }
                                }
                            }
                            .padding(.trailing, 16)
                        }
                    }
                    .frame(width: UIScreen.screenWidth - 40, height: 42)
                    
                    HStack {
                        Text("명언 성향")
                            .pretendardFont(family: .Medium, size: 14)
                            .foregroundColor(.basicGray7)
                            .padding(EdgeInsets(top: 10, leading: 16, bottom: 18, trailing: 0))
                        
                        Spacer()
                        
                        if viewModel.selectedFlavorArray.count > 2  || viewModel.selectedFlavorArray.count == 0 {
                            HStack{
                                HStack {
                                    Text("성향 전체")
                                        .pretendardFont(family: .SemiBold, size: 12)
                                }
                                .foregroundColor(.basicGray7)
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
                                .onTapGesture {
                                    withAnimation {
                                        sheetManager.present(with: .init(idx: 1))
                                        sheetManager.isPopup = true
                                    }
                                }
                                .padding(.trailing, 16)

                            }
                        } else {
                            ForEach(viewModel.selectedFlavorArray, id: \.self) { character in
                                
                                HStack{
                                    HStack {
                                        Image(assetName: character.type.smallIconImageName)
                                        Text(character.type.korean)
                                            .pretendardFont(family: .SemiBold, size: 12)
                                    }
                                    .foregroundColor(.mildIconText)
                                    .frame(minWidth: 71, maxHeight: 28)
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
                                    .onTapGesture {
                                        withAnimation {
                                            sheetManager.present(with: .init(idx: 1))
                                            sheetManager.isPopup = true
                                        }
                                    }
                                }
                            }
                            .padding(.trailing, 16)
                        }
                        
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
                                if let appstoreUrl = URL(string: "https://apps.apple.com/app/id6472920141") {
                                    var urlComp = URLComponents(url: appstoreUrl, resolvingAgainstBaseURL: false)
                                    urlComp?.queryItems = [
                                        URLQueryItem(name: "action", value: "write-review")
                                    ]
                                    guard let reviewUrl = urlComp?.url else {
                                        return
                                    }
                                    UIApplication.shared.open(reviewUrl, options: [:], completionHandler: nil)
                                }
                                break
                            case "settingImage":
                                profileViewModel.gotoOtherSettingView.toggle()
                                
                            case "bugImage":
                                guard let subject = "문의/제휴".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                                      let body = """
                                    아래 내용을 적어주세요. 빠르게 답변 드리겠습니다.\n
                                    • 이용 중인 기기/OS 버전:\n
                                    • 닉네임: \n
                                    • 문의 내용:
                                    """.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                                      let url = URL(string: "mailto:myungeon.bakery.app@gmail.com?subject=\(subject)&body=\(body)") else {
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
                viewModel.isLogin = false
                viewModel.isLoginCheck = false
                authViewModel.randomAuthNickName = ""
                presentationMode.wrappedValue.dismiss()
                
            }
    }
}
