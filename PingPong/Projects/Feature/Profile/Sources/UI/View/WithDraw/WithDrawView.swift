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
}


