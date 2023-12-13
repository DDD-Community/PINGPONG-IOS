//
//  WithDrawView.swift
//  Profile
//
//  Created by 서원지 on 11/18/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import Model
import Authorization
import SwiftUI
import PopupView


struct WithDrawView: View {
    @StateObject private var profileViewModel: ProfileViewViewModel
    @StateObject var viewModel: CommonViewViewModel
    @StateObject var authViewModel: AuthorizationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    public init(
        authViewModel: AuthorizationViewModel,
        viewModel: CommonViewViewModel,
        profileViewModel: ProfileViewViewModel
    ) {
        self._authViewModel = StateObject(wrappedValue: authViewModel)
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._profileViewModel = StateObject(wrappedValue: profileViewModel)
    }
    
    var body: some View {
        ZStack {
            Color.basicGray2
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                topHeaderBackButton()
                
                withDrawViewTitle()
                
                CustomDropdownMenu(
                    isSelecting: $profileViewModel.isSelectDropDownMenu,
                    selectionTitle: $profileViewModel.selectWithDrawReason
                )
                
            selectWithDrawButton()
                
                Spacer()
            }
        }
        
        
        .popup(isPresented: $profileViewModel.selectWithDrawPOPUP) {
            WithDrawPOPUP(
                image: .errorCircle_rounded,
                title: "정말로 탈퇴 하시겠습니까?",
                subTitle: "탈퇴하시면 명언제과점을 이용하실수 없어요!",
                confirmAction: {
                    Task {
                        await profileViewModel.withDrawPost(userID: "\(authViewModel.userid)", reason: profileViewModel.selectWithDrawReason,  successCompletion: {
//                            authViewModel.deleteAuth = true
                            profileViewModel.selectWithDrawPOPUP = false
                            viewModel.isLoginCheck = false
                            profileViewModel.randomNickName = ""
                            authViewModel.userid = ""
                            authViewModel.userNickName = ""
                            presentationMode.wrappedValue.dismiss()
                            viewModel.isFirstUserPOPUP = false
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                authViewModel.deleteAuth = true
                            }
                            
                        })
                    }
                    
                },
                cancelAction: {
                    profileViewModel.selectWithDrawPOPUP = false
                }, noImage: false, noImageButton: false)
            
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
    private func withDrawViewTitle() -> some View {
        VStack {
            HStack {
                Text("어떤 점이 불편하셨는지")
                    .padding(.leading, 20)
                Spacer()
            }
            HStack {
                Text("말씀해 주실 수 있을까요?")
                    .padding(.leading, 20)
                Spacer()
            }
        }
        .frame(width: UIScreen.screenWidth, height: 96, alignment: .leading)
        .foregroundColor(.basicGray9)
        
        .pretendardFont(family: .Medium, size: 18)
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
                    
                    Text("회원 탈퇴")
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
    private func selectWithDrawButton() -> some View {
        Spacer()
            .frame(height: 28)
        
        if !profileViewModel.isSelectDropDownMenu {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.basicGray3)
                .frame(height: 56)
                .padding(.horizontal, 20)
                .overlay {
                    Text("탈퇴하기")
                        .foregroundStyle(Color.basicGray5)
                        .pretendardFont(family: .Medium, size: 14)
                    
                }
                .onTapGesture {
                    profileViewModel.selectWithDrawPOPUP.toggle()
                }
        }
    }
}


