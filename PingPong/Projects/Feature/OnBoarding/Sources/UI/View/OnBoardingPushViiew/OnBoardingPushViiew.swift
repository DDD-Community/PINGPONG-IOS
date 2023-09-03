//
//  OnBoardingPushViiew.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import DesignSystem
import SwiftUI

public struct OnBoardingPushViiew: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var appState : OnBoardingAppState = OnBoardingAppState()
    @StateObject var viewModel: OnBoardingViewModel
   
    
    public init(viewModel: OnBoardingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                Color.basicWhite
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        onboardingBackButton()
                        
                        exampleWiseSayingView()
                        
                        stepContentTitleView()
                        
                        selectTimeContent()
                        
                        Spacer()
                        
                        selectOnBoardingPushButton()
                    }
                }
                .bounce(false)
            }
            .navigationDestination(isPresented: $appState.completPushNotificationView) {
                CompletedPushNotificationView(isActivePushNotifcation: $appState.isOnOFFToggle, viewModel: self.viewModel)
                    .navigationBarHidden(true)
            }
            
        }
    }
    
    @ViewBuilder
    private func onboardingBackButton() -> some View {
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
                
                Text("건너뛰기")
                    .pretendardFont(family: .Regular, size: 14)
                    .foregroundColor(.basicGray6)
                    .onTapGesture {
                        appState.completPushNotificationView.toggle()
                    }
                
                Spacer()
                    .frame(width: 23)
                
            }
        }
    }
    
    @ViewBuilder
    private func exampleWiseSayingView() -> some View {
        Spacer()
            .frame(height: 12)
        
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.basicGray3)
                .frame(width: UIScreen.screenWidth - 40, height: 120)
                .overlay {
                    HStack {
                        RoundedRectangle(cornerRadius: 8.67)
                            .fill(Color.primaryOrange)
                            .frame(width: 38, height: 38)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("오늘의 명언")
                                    .pretendardFont(family: .SemiBold, size: 16)
                                Spacer()
                            }
                            HStack {
                                Text("스스로 돌아봐도 잘못이 없다면  천만인이")
                                    .pretendardFont(family: .Regular, size: 14)
                                    .foregroundColor(Color.basicGray8)
                                
                               Spacer()
                            }
                            HStack {
                                Text("가로막더라도 나는 가리라")
                                    .pretendardFont(family: .Regular, size: 14)
                                    .foregroundColor(Color.basicGray8)
                            Spacer()
                            }
                            
                            Text("-맹자-")
                                .pretendardFont(family: .Regular, size: 14)
                                .foregroundColor(Color.basicGray8)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                }
        }
    }
    
    @ViewBuilder
    private func stepContentTitleView() -> some View {
        Spacer()
            .frame(height: 28)
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("STEP 3/3")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(Color.primaryOrange)
                
                Spacer()
            }
            
            Text("갓 나온 따근따근한 명언 배달은")
                .pretendardFont(family: .SemiBold, size: 24)
                .foregroundColor(.black)
            
            Text("어떠신가요?")
                .pretendardFont(family: .SemiBold, size: 24)
                .foregroundColor(.black)
            
            Text("푸쉬 알림을 설정 하면")
                .pretendardFont(family: .Regular, size: 18)
                .foregroundColor(Color.basicGray6)
            
            Text("제빵사님을 위한 명언을 보내드려요")
                .pretendardFont(family: .Regular, size: 18)
                .foregroundColor(Color.basicGray6)
        
            
        }
        .padding(.horizontal, 20)
        
    }
    
    @ViewBuilder
    private func selectTimeContent()  -> some View {
            Spacer()
                .frame(height: 81)
            
            HStack {
                Spacer()
                
                VStack {
                    if !appState.ishiddenRectangle {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.basicGray3)
                            .frame(width: 176, height: 76)
                            .overlay(
                                HStack {
                                    Text(String.formattedTime(appState.selectedTime))
                                        .foregroundColor(appState.isOnOFFToggle ? Color.basicGray9 : Color.basicGray6)
                                        .pretendardFont(family: .Bold, size: 18)
                                    
                                    Spacer()
                                    
                                    Text(String.formattedTimeWithoutAmPm(appState.selectedTime))
                                        .foregroundColor(appState.isOnOFFToggle ? Color.basicGray9 : Color.basicGray6)
                                        .pretendardFont(family: .Bold, size: 18)
                                }
                                    .padding(.horizontal)
                            )
                            .onTapGesture {
                                appState.ishiddenRectangle.toggle()
                                    appState.isPickerPresented.toggle()
                                
                            }
                    }
                    if appState.isPickerPresented {
                        DatePicker("", selection: $appState.selectedTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(width: 200, height: 212)
                            .foregroundColor(Color.basicGray9)
                            .pretendardFont(family: .SemiBold, size: 18)
                    }
                }
                .onTapGesture {
                    appState.ishiddenRectangle.toggle()
                        appState.isPickerPresented.toggle()
                }
                .padding(.leading, 20)
                
                Spacer()
                    .frame(width: 24)
                
                Toggle("", isOn: $appState.isOnOFFToggle)
                    .toggleStyle(CustomToggle(activeColor: Color.primaryOrange, activeCircle: appState.isOnOFFToggle, height: 31, width: 51, noActiveColor: Color.basicGray4))
                    .padding(.trailing, 20)
    //                .offset(x: -50)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
           
        }


    
    @ViewBuilder
    private func selectOnBoardingPushButton() -> some View {
        Spacer()
            .frame(height: 80)
        
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(appState.isOnOFFToggle ? Color.primaryOrange : Color.basicGray3)
                .frame(width: UIScreen.screenWidth - 40 , height: 56)
                .overlay {
                    Text("허용 및 저장")
                        .pretendardFont(family: .SemiBold, size: 16)
                        .foregroundColor(appState.isOnOFFToggle ? Color.basicWhite : Color.basicGray5)
                }
                .disabled(appState.isOnOFFToggle)
                .onTapGesture {
                    if appState.isOnOFFToggle {
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
                                            appState.completPushNotificationView.toggle()
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
                    appState.completPushNotificationView.toggle()
                }
            
        }
    }
}
