//
//  OnBoardingAppState.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/08/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI
import Model

class OnBoardingAppState: ObservableObject {
    @State var netWorkErrorPOP: Bool = false
    @State var errorMessage: String = ""
    @Published var serviceUseAgmentView: Bool = false
    @Published var signUPFaillPOPUP: Bool = false
    
    @Published public var selectedTime = Date()
    @Published public var isPickerPresented = false
    @Published public var ishiddenRectangle: Bool = false
    @Published public var isOnOffToggle: Bool = false
    @Published public var completPushNotificationView: Bool = false
    @Published public var completOnBoardingView: Bool = false
    @Published public var allConfirmAgreeView: Bool = false
    @Published public var goToCompleteLoginView: Bool = false
    @Published public var isActivePushNotifcation: Bool = false
    @Published public var goToSettingPushNotifcationView: Bool = false
    @Published public var failRegisterFlavorPOPUP: Bool = false
    @Published public var goToMainHomeView: Bool = false
}
