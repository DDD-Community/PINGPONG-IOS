//
//  UnicodeModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct UnicodeRange {
    public let unicodeType: UnicodeType
    public let from: Int
    public let to: Int
    
    public init(unicodeType: UnicodeType, from: Int, to: Int) {
        self.unicodeType = unicodeType
        self.from = from
        self.to = to
    }
}

public enum UnicodeType {
    case korean
    case english
    case number
}

public enum NicknameValidationType {
    case notValidated
    case valid
    case invalid
    case duplicate
}
