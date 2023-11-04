//
//  SearchOptionModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct SearchOption: Hashable, Identifiable {
    public let id: UUID = UUID()
    public var korean: String
    public var english: String
    public var iconImageName: String
    public var detail: String
    public var isCheck: Bool = false
    
    
    public init(korean: String, english: String, iconImageName: String, detail: String) {
        self.korean = korean
        self.english = english
        self.iconImageName = iconImageName
        self.detail = detail
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(detail)
        hasher.combine(korean)
    }
    
    public static func == (lhs: SearchOption, rhs: SearchOption) -> Bool {
        return lhs.detail == rhs.detail && lhs.korean == rhs.korean
    }
}
