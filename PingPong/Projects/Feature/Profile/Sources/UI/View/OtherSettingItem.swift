//
//  OtherSettingItem.swift
//  Profile
//
//  Created by 서원지 on 11/8/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

enum OhterSettingItem: CaseIterable, CustomStringConvertible {
    case privacyPolicy
    case termsOfService
    case withDraw
    case appVersion
    
    var description: String {
        switch self {
        case .privacyPolicy:
            return "개인정보처리방침"
        case .termsOfService:
            return "서비스 이용약관"
        case .withDraw:
            return "회원탈퇴"
        case .appVersion:
            return "앱 버전"
        }
    }
}
