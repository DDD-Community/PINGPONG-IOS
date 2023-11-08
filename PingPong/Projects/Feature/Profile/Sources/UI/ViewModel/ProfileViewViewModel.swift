//
//  ProfileViewViewModel.swift
//  Profile
//
//  Created by Byeon jinha on 2023/11/06.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI
import Service
import Combine
import CombineMoya
import Model
import Moya
import API
import DesignSystem

public class ProfileViewViewModel: ObservableObject {
    @State var selectOtherSettingItem: OhterSettingItem = .privacyPolicy
     let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    public init() {
        
    }
    
    
}
