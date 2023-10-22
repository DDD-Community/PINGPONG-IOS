//
//  OptionButtonInfo.swift
//  Model
//
//  Created by 서원지 on 10/22/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct OptionButtonInfo {
    public let title: String
    public let count: Int
    
    public init(title: String, count: Int) {
        self.title = title
        self.count = count
    }
}
