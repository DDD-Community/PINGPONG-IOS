//
//  PushSettingViewModel.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

class PushSettingViewModel: ObservableObject {
    @Published var bakeBreadView: Bool = false
    @Published var isNoti: Bool = false
    @Published var hour: Date = Date()
}
