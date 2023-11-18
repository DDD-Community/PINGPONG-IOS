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
                
                withDrawText
                
                Spacer()
            }
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
    
    private var withDrawText: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            HStack {
                Text("어떤 점이 불편하셨는지\n 말씀해 주실 수 있을까요?")
                    .pretendardFont(family: .Medium, size: 18)
                    .foregroundColor(Color.basicGray9)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}


