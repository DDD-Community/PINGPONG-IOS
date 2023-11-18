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


struct WithDrawView: View {
    @StateObject private var profileViewModel: ProfileViewViewModel = ProfileViewViewModel()
    @ObservedObject var authViewModel: AuthorizationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    public init(authViewModel: AuthorizationViewModel) {
        self._authViewModel = ObservedObject(wrappedValue: authViewModel)
    }
    
    var body: some View {
        ZStack {
            Color.basicGray2
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                topHeaderBackButton()
                withDrawViewTitle()
                CustomDropdownMenu()
                Spacer()
            }
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
}


