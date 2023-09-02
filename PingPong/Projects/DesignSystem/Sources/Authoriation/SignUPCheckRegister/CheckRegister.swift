//
//  CheckRegister.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Model
import SwiftUI

public struct CheckRegister {
    
    @discardableResult
    public static func generateUnicodeArray() -> [Character] {
        var unicodeArray: [Character] = []
        let unicodeRanges = [
            UnicodeRange(unicodeType: .korean, from: 0xAC00, to: 0xD7A4),
            UnicodeRange(unicodeType: .number, from: 0x0030, to: 0x0039),
            UnicodeRange(unicodeType: .english, from: 0x0041, to: 0x005B),
            UnicodeRange(unicodeType: .english, from: 0x0061, to: 0x007B)
        ]
        
        unicodeRanges.forEach { unicode in
            let unicodeComponentArray = generateComponentUnicodeArray(from: unicode.from, to: unicode.to)
            unicodeArray += unicodeComponentArray
        }
        return unicodeArray
    }
    
    @discardableResult
    public static func generateComponentUnicodeArray(from: Int, to: Int) -> [Character]{
        var unicodeArray: [Character] = []
        for codePoint in from..<to {
            if let character = UnicodeScalar(codePoint) {
                unicodeArray.append(Character(character))
            }
        }
        return unicodeArray
    }
    
    @discardableResult
    public static func generateValidationColor(validation: NicknameValidationType) -> Color {
        switch validation {
        case .duplicate: return Color.statusWarning
        case .invalid: return Color.statusWarning
        case .notValidated: return Color.basicGray5
        case .valid: return Color.statusSuccess
        }
    }
    
    @discardableResult
    public static func generateValidationText(validation: NicknameValidationType) -> String {
        switch validation {
        case .duplicate: return "이미 사용중인 닉네임이에요."
        case .invalid: return "닉네임 형식이 올바르지 않아요.  *특수문자 제외 12자 이하"
        case .notValidated: return ""
        case .valid: return "사용 가능한 닉네임이에요!"
        }
    }
    @discardableResult
    public static func generateValidationImage(validation: NicknameValidationType) -> String? {
        switch validation {
        case .duplicate: return "exclamationmark.circle"
        case .invalid: return "exclamationmark.circle"
        case .notValidated: return nil
        case .valid: return "checkmark.circle"
        }
    }
}
