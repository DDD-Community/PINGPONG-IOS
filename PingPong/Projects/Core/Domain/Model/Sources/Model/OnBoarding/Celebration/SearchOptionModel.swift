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
    public var val: String
    public var iconImageName: String
    public var detail: String
    public var isCheck: Bool = false
    
    
    public init(val: String, iconImageName: String, detail: String) {
        self.val = val
        self.iconImageName = iconImageName
        self.detail = detail
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(detail)
        hasher.combine(val)
    }
    
    public static func == (lhs: SearchOption, rhs: SearchOption) -> Bool {
        return lhs.detail == rhs.detail && lhs.val == rhs.val
    }
}
