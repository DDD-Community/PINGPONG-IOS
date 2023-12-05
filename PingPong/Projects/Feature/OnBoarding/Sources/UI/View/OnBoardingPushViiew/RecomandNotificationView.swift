//
//  RecomandPushNotificationView.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import DesignSystem
import SwiftUI
import Authorization
import Common
import Model

public struct RecomandPushNotificationView: View {
    @Environment(\.presentationMode)  var presentationMode
    @StateObject var viewModel: OnBoardingViewModel
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    @StateObject var appState: OnBoardingAppState = OnBoardingAppState()
    @StateObject var commonViewViewModel: CommonViewViewModel
    
    public init( viewModel: OnBoardingViewModel, commonViewViewModel: CommonViewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._commonViewViewModel = StateObject(wrappedValue: commonViewViewModel)
    }
    
    public var body: some View {
        VStack {
            completedPushBackButton()
            
            completedPushTitleComponetnt()
            
            completedPushImage()
            
            completdPushNotificationButton()
            
            Spacer()
        }
        
        .navigationDestination(isPresented: $appState.completOnBoardingView) {
            CompletOnBoardingView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                .environmentObject(authViewModel)
                .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden()
        
    }
    
    @ViewBuilder
    private func completedPushBackButton() -> some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            HStack {
                Spacer()
                    .frame(width: 20)
                
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 18)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
                Spacer()
                
            }
        }
    }
    
    @ViewBuilder
    private func completedPushTitleComponetnt() -> some View {
        Spacer()
            .frame(height: 20)
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("명언제과점은")
                    .pretendardFont(family: .SemiBold, size: 24)
                    .foregroundColor(Color.basicGray9)
                Spacer()
            }
            
            Text("알림과 함께할 때 더욱 맛있어요!")
                .pretendardFont(family: .SemiBold, size: 24)
                .foregroundColor(Color.basicGray9)
            
            Spacer()
                .frame(height: 12)
            
            Text("알림을 활성하여")
                .pretendardFont(family: .SemiBold, size: 18)
                .foregroundColor(Color.basicGray6)
            
            Text("명언 인용문을 받아보세요")
                .pretendardFont(family: .SemiBold, size: 18)
                .foregroundColor(Color.basicGray6)
            
            
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func completedPushImage() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.1)
        
        HStack {
            
            Image(asset: .pushivew)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth - 40 , height: UIScreen.screenHeight*0.3)
        }
    }
    
    @ViewBuilder
    private func completdPushNotificationButton() -> some View {
        Spacer()
            .frame(height: UIScreen.main.bounds.height.native == 667 ? UIScreen.screenHeight*0.1 - (UIScreen.screenWidth*0.1) : UIScreen.main.bounds.height.native >= 926 ? UIScreen.screenHeight*0.3 : UIScreen.screenHeight*0.1)
        
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(appState.isActivePushNotifcation ? Color.primaryOrange : Color.basicGray3)
                .frame(width: UIScreen.screenWidth - 40 , height: 56)
                .overlay {
                    Text("활성화할께요")
                        .pretendardFont(family: .SemiBold, size: 16)
                        .foregroundColor(appState.isActivePushNotifcation ? Color.basicWhite : Color.basicGray5)
                }
                .disabled(appState.isActivePushNotifcation)
                .onTapGesture {
                    appState.isActivePushNotifcation.toggle()
                    authViewModel.isNotification.toggle()
//                    authViewModel.isActiveNotification.toggle()
                    
                    if appState.isActivePushNotifcation {
                        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                        UNUserNotificationCenter.current().requestAuthorization(
                            options: authOptions,
                            completionHandler: { granted, _ in
                                if granted {
                                    DispatchQueue.main.async {
                                        let content = UNMutableNotificationContent()
                                        content.title = "알림 테스트"
                                        content.body = "푸시 알림이 허용되었습니다."
                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                                        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
                                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            appState.completOnBoardingView.toggle()
                                        }
                                        
                                    }
                                }
                                else {
                                    DispatchQueue.main.async {
                                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                            if UIApplication.shared.canOpenURL(settingsURL) {
                                                UIApplication.shared.open(settingsURL)
                                            }
                                        }
                                    }
                                }
                            }
                        )
                    }
                }
            
            Spacer()
                .frame(height: 8)
            
            Text("다음에 할께요")
                .pretendardFont(family: .SemiBold, size: 16)
                .foregroundColor(Color.basicGray5)
                .onTapGesture {
                    appState.completOnBoardingView.toggle()
                }
            
            
            
        }
    }
}
