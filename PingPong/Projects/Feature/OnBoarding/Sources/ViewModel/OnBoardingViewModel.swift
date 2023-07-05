//
//  OnBoardingViewModel.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/07/01.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

final class OnBoardingViewModel: ObservableObject {
    @Published var allAgreeCheckButton: Bool = false
    @Published var check14yearsAgreeButton: Bool = false
    @Published var checkTermsService: Bool = false
    @Published var checkPesonalInformation: Bool = false
    @Published var checkReciveMarketingInformation: Bool = false
    @Published var allConfirmAgreeView: Bool = false
    @Published var goToFavoriteViseView: Bool = false
    
    //MARK: -  동의 하는 관련  함수
    func updateAgreementStatus() {
        if !allAgreeCheckButton || !check14yearsAgreeButton || !checkTermsService || !checkPesonalInformation || !checkReciveMarketingInformation {
            allAgreeCheckButton = true
            check14yearsAgreeButton = true
            checkTermsService = true
            checkPesonalInformation = true
            checkReciveMarketingInformation = true
        } else {
            allAgreeCheckButton = false
            check14yearsAgreeButton = false
            checkTermsService = false
            checkPesonalInformation = false
            checkReciveMarketingInformation = false
        }
    }
    
    
    
}
