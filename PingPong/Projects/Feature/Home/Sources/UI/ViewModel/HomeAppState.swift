//
//  HomeAppState.swift
//  Home
//
//  Created by 서원지 on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI


public class HomeAppState: ObservableObject {
    @Published var goToProfileSettingView: Bool = false
    @Published var goToBackingView: Bool = false
    @Published var goToMainView: Bool = false
}
