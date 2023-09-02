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
    @Published var allAgreeCheckButton: Bool = false
    @Published var checkTermsService: Bool = false
    @Published var checkPesonalInformation: Bool = false
    @Published var checkReciveMarketingInformation: Bool = false
    @Published var allConfirmAgreeView: Bool = false
    @Published var goToFavoriteViseView: Bool = false
    
    @Published var nickname: String = ""
    
    @Published var nicknameValidation: NicknameValidationType = .notValidated
    @Published var validationText: String = " "
    @Published var validationColor: Color = .basicGray4
    @Published var validationImageName: String?
    
}
