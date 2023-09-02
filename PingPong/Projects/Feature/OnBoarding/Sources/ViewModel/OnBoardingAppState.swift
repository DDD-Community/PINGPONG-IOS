//
//  OnBoardingAppState.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/08/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

class OnBoardingAppState: ObservableObject {
    @State var netWorkErrorPOP: Bool = false
    @State var errorMessage: String = ""
    @Published var serviceUseAgmentView: Bool = false
    
}
