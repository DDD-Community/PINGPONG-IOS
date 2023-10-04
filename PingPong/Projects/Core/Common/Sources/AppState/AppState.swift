//
//  AppState.swift
//  Common
//
//  Created by Byeon jinha on 2023/10/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

public class AppState: ObservableObject {
    @Published public var goToProfileSettingView: Bool = false
    @Published public var goToBackingView: Bool = false
    @Published public var goToMainView: Bool = false
    
    // MARK: 오늘의 명언굽기 State
    @Published public var isStartBake: Bool = false
    @Published public var isTodayBake: Bool = false
    @Published public var isChoicedBread: Bool = false
    @Published public var isChoicedIngredent: Bool = false
    @Published public var isChoicedTopping: Bool = false
    @Published public var isCompleteBake: Bool = false
    
    public init() {
        // 초기화 로직을 여기에 추가할 수 있습니다.
    }
}

