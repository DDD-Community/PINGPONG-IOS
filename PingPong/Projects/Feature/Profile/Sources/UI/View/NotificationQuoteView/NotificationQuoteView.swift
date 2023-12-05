//
//  NotificationQuoteView.swift
//  Profile
//
//  Created by 서원지 on 11/18/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Common
import DesignSystem
import Authorization

struct NotificationQuoteView: View {
    @StateObject private var profileViewModel: ProfileViewViewModel = ProfileViewViewModel()
    @StateObject var authViewModel: AuthorizationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    public init(
        authViewModel: AuthorizationViewModel
    ) {
        self._authViewModel = StateObject(wrappedValue: authViewModel)
    }
    
    var body: some View {
        ZStack {
            Color.basicGray2
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                topHeaderBackButton()
                
                notifiCationQuoteToggle()
                
                if authViewModel.isNotification {
                    addTimeNotification()
                }
                
                Spacer()
            }
        }
        
        .onAppear {
            if authViewModel.isNotification {
                authViewModel.isActiveNotification = true
            } else {
                authViewModel.isActiveNotification = false
            }
        }
        
        .onChange(of: authViewModel.isActiveNotification) { newValue in
            authViewModel.isActiveNotification = newValue
            
            if authViewModel.isActiveNotification == false {
                profileViewModel.selectedChangeTimeView = false
            }
        }
        
        .sheet(isPresented: $profileViewModel.selectTimeBottomView) {
            SelectTimeSheetView(
                viewModel: profileViewModel,
                closeSheetAction: {
                    profileViewModel.selectTimeBottomView = false
                    profileViewModel.selectedChangeTimeView = true
                    
                    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

                    UNUserNotificationCenter.current().requestAuthorization(
                        options: authOptions,
                        completionHandler: { granted, _ in
                            if granted {
                                DispatchQueue.main.async {
                                    let content = UNMutableNotificationContent()
                                    content.title = "명언"
                                    content.body = "오늘의 새로운 명언을 확인 해주세요!"

                                    // Extracting hour and minute from selectedTime
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.hour, from: profileViewModel.selectedTime)
                                    let minute = calendar.component(.minute, from: profileViewModel.selectedTime)
                                    var dateComponents = DateComponents()
                                    dateComponents.hour = hour
                                    dateComponents.minute = minute

                                    // Create the trigger
//                                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//                                    let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
                                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                                    let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
                                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

                                    // Additional code...
                                }
                            } else {
                                // Code for handling the denial of notification permission...
                            }
                        }
                        )
                    
                })
                .presentationDetents([UIScreen.main.bounds.height.native == 667 ? .height(UIScreen.screenHeight/2 + UIScreen.screenWidth*0.2) : .height(UIScreen.screenHeight/3 + UIScreen.screenWidth*0.2)])
                .presentationCornerRadius(20)
        }
        
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        Spacer()
            .frame(height: 18)
        
        HStack {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 18)
                    .foregroundColor(.basicGray8)
                   
                Text("명언 알림")
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
    private func notifiCationQuoteToggle() -> some View {
        Spacer()
            .frame(height: 14)
        
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.basicWhite)
            .frame(height: 84)
            .padding(.horizontal, 20)
            .overlay {
                VStack(spacing: .zero) {
                    Spacer()
                        .frame(height: 20)
                    
                    HStack(spacing: .zero) {
                        Spacer()
                            .frame(width: 16)
                        
                        VStack(alignment: .leading, spacing: .zero) {
                            HStack {
                                Text("명언 알림 메세지")
                                    .pretendardFont(family: .Medium, size: 16)
                                    .foregroundColor(Color.basicGray9)
                            }
                            
                            Spacer()
                                .frame(height: 2)
                            
                            Text("당신을 위한 명언을 배송해드려요")
                                .pretendardFont(family: .Regular, size: 12)
                                .foregroundColor(Color.basicGray6)
                        }
//                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        Toggle("", isOn: $authViewModel.isNotification)
                            .toggleStyle(CustomToggle(activeColor: Color.primaryOrange, activeCircle: authViewModel.isActiveNotification, height: 31, width: 51, noActiveColor: Color.basicGray4))
                        
                        Spacer()
                            .frame(width: 16)
//                            .padding(.trailing, 16)
                    }
                    
                    Spacer()
                        .frame(height: 20)
                }
                .padding(.horizontal, 16)
            }
          
    }
    
    @ViewBuilder
    private func addTimeNotification() -> some View {
        Spacer()
            .frame(height: 11)
        
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.basicWhite)
            .frame(height: 64)
            .padding(.horizontal, 20)
            .overlay {
                VStack {
                    if !profileViewModel.selectedChangeTimeView {
                        HStack(spacing: .zero) {
                            Spacer()
                                .frame(width: 20)
                            
                            Image(asset: .selectClock)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Spacer()
                                .frame(width: 8)
                            
                            Text("시간 추가")
                                .pretendardFont(family: .Medium, size: 16)
                                .foregroundColor(Color.basicGray9)
                            
                            Spacer()
                            
                            Image(asset: .selectTimeAdd)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                            
                            Spacer()
                                .frame(width: 20)
                            
                        }
                        .onTapGesture {
                            profileViewModel.selectTimeBottomView.toggle()
                        }
                    } else {
                        HStack(spacing: .zero) {
                            Spacer()
                                .frame(width: 16)
                            
                            Text(String.formattedHourTime(profileViewModel.selectedTime))
                                .foregroundStyle(Color.basicGray9)
                                .pretendardFont(family: .Medium, size: 16)
                            
                            Spacer()
                            
                            Text("수정")
                                .pretendardFont(family: .SemiBold, size: 14)
                                .foregroundColor(Color.statusWarning)
                                .onTapGesture {
                                    profileViewModel.selectTimeBottomView.toggle()
                                    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

                                    UNUserNotificationCenter.current().requestAuthorization(
                                        options: authOptions,
                                        completionHandler: { granted, _ in
                                            if granted {
                                                DispatchQueue.main.async {
                                                    let content = UNMutableNotificationContent()
                                                    content.title = "명언"
                                                    content.body = "오늘의 새로운 명언을 확인 해주세요!"

                                                    // Extracting hour and minute from selectedTime
                                                    let calendar = Calendar.current
                                                    let hour = calendar.component(.hour, from: profileViewModel.selectedTime)
                                                    let minute = calendar.component(.minute, from: profileViewModel.selectedTime)

                                                    var dateComponents = DateComponents()
                                                    dateComponents.hour = hour
                                                    dateComponents.minute = minute

                                                    // Create the trigger
//                                                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//                                                    let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
                                                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                                                    let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
                                                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                                                    
                                                    // Additional code...
                                                }
                                            } else {
                                                // Code for handling the denial of notification permission...
                                            }
                                        }
                                        )
                                    
                                }
                            
                            
                            Spacer()
                                .frame(width: 16)
                            
                        }
                        
                    }
                }
                .padding(.horizontal, 20)
            }
        
    }
}


