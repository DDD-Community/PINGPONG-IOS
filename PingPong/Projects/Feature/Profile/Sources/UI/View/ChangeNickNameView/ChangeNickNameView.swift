//
//  ChangeNickNameView.swift
//  Profile
//
//  Created by 서원지 on 11/21/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import Model
import Authorization
import SwiftUI
import PopupView

struct ChangeNickNameView: View {
    @ObservedObject private var viewModel: ProfileViewViewModel
    @ObservedObject private var authViewModel: AuthorizationViewModel
    
    var closeSheet: () -> Void
    
    
    
    init(
        viewModel: ProfileViewViewModel,
        authViewModel: AuthorizationViewModel,
        closeSheet: @escaping () -> Void
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self._authViewModel = ObservedObject(wrappedValue: authViewModel)
        self.closeSheet = closeSheet
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 32)
            
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.basicGray4, lineWidth: 1)
                .frame(width: UIScreen.screenWidth - 40, height: 52)
                .overlay(
                    ZStack {
                        TextField("변경할 닉네임을 알려주세요", text: $viewModel.changeNickName)
                            .foregroundColor(Color.black)
                            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 34))
                            .preferredColorScheme(.light)
                            .onChange(of: viewModel.changeNickName, perform: { newValue in
                                viewModel.changeNickName = newValue
                            })
                        
                        HStack {
                            Spacer()
                            Image(systemName: "x.circle.fill")
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 10)
                                .foregroundColor(.basicGray4)
                                .onTapGesture {
                                    viewModel.changeNickName = ""
                                }
                        }
                    }
                )
            
            
            
            Spacer()
            
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.primaryOrange)
                .frame(width: UIScreen.screenWidth - 40, height: 52)
                .overlay {
                    Text("변경하기")
                        .pretendardFont(family: .Medium, size: 18)
                        .foregroundColor(Color.basicWhite)
                }
                .onTapGesture {
                    Task {
                        await viewModel.changeNickName(
                            userID: "\(authViewModel.userid)",
                            nickName: viewModel.changeNickName) {
                                authViewModel.searchUserIdRequest(uid: "\(authViewModel.userid)")
                        }
                    }
                    closeSheet()
                }
            
            Spacer()
                .frame(height: 32)
            
            
        }
        
        

    }
}

