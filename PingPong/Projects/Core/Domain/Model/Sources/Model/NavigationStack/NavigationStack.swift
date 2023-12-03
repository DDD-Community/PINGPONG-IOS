//
//  NavigationStack.swift
//  Model
//
//  Created by Byeon jinha on 12/3/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum ViewState:String, Hashable {
    case isStartLogin
    case isStartEnter
    case isStartServiceAgreement
    case isServiceAgreeComplete
    case isNickNameComplete
    case isJobSettingComplete
    case isCompleteLogin
    case isStartChoiceFavorite
    case isSelectedCategory
    case isSelectedCharacter
    case isCompleteOnboarding
    case isDeniedNoti
    case isLoginned
}
