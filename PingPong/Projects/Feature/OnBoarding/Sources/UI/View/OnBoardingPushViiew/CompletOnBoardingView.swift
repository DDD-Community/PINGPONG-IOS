//
//  CompletOnBoardingView.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import Foundation
import SwiftUI
import DesignSystem
import Authorization
import Home
import Core
import Model

public struct CompletOnBoardingView: View {
    @Environment(\.presentationMode) var  presentationMode
    @StateObject var authViewModel: AuthorizationViewModel
    @StateObject var viewModel: OnBoardingViewModel
    @StateObject var commonViewViewModel: CommonViewViewModel
    
    public init(
        viewModel: OnBoardingViewModel,
        commonViewViewModel: CommonViewViewModel,
        authViewModel: AuthorizationViewModel
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._commonViewViewModel = StateObject(wrappedValue: commonViewViewModel)
        self._authViewModel = StateObject(wrappedValue: authViewModel)
    }
    
    public var body: some View {
        VStack {
            favoriteRegistrationTitle()
            
            favoriteRegistrationImage()
            
            completedOnBoardingButton()
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        
        .task {
            authViewModel.searchUserIdRequest(uid: "\(authViewModel.userid)", failCompletion: {})
            await authViewModel.randomNameRequest(commCdTpCd: .userDesc, completion: {_ in })
        }
    }
    
    @ViewBuilder
    private func favoriteRegistrationTitle() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.1)
        
        VStack(alignment: .leading ,spacing: 8) {
            HStack {
                Text("취향 등록 완료")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(Color.primaryOrange)
                
                Spacer()
                
                
            }
            
            Text("\(authViewModel.userNickName)님에게")
                .pretendardFont(family: .SemiBold, size: 24)
                .foregroundColor(Color.black)
            
            HStack(spacing: .zero) {
                Text("\(authViewModel.userRmk)")
                    .pretendardFont(family: .SemiBold, size: 25)
                    .foregroundColor(Color.primaryOrange)
                
                HStack(spacing: .zero) {
                    Text("\(authViewModel.randomAuthNickName)")
                        .pretendardFont(family: .SemiBold, size: 25)
                        .foregroundColor(Color.primaryOrange)
                    Text("으로")
                        .pretendardFont(family: .SemiBold, size: 25)
                        .foregroundColor(Color.basicGray9)
                }
                
                Spacer()
            }
            
            Text("초대합니다")
                .pretendardFont(family: .SemiBold, size: 24)
                .foregroundColor(Color.black)
            
            Text("취향에 맞는 명언을 추천드릴께요")
                .pretendardFont(family: .Medium, size: 18)
                .foregroundColor(Color.basicGray6)
            
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func favoriteRegistrationImage() -> some View {
        Spacer()
            .frame(height: UIScreen.main.bounds.height.native == 667 ? 20 : 53)
        VStack {
            Image(asset: .completOnboarding)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth - 40, height: 277)
        }
    }
    
    @ViewBuilder
    private func completedOnBoardingButton() -> some View {
        Spacer()
            .frame(height: UIScreen.main.bounds.height.native >= 927 ? UIScreen.screenWidth*0.4 : UIScreen.main.bounds.height == 667 ? 41.3 : UIScreen.screenWidth*0.3)
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.primaryOrange)
                .frame(width: UIScreen.screenWidth - 40 , height: 56)
                .overlay {
                    Text("시작하기")
                        .foregroundColor(Color.basicWhite)
                        .pretendardFont(family: .SemiBold, size: 16)
                }
                .onTapGesture {
                    //MARK: -  취향 등록 api  성공 후 mainview  로직
                    
                    commonViewViewModel.isLogin = true
                    commonViewViewModel.isLoginCheck = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        commonViewViewModel.isFirstUserPOPUP = true
                    }
                    
                }
        }
    }
   
}
