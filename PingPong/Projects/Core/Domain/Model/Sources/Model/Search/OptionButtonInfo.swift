//
//  OptionButtonInfo.swift
//  Model
//
//  Created by 서원지 on 10/22/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public class OptionButtonInfo {
    
    public let defaultTitle: SearchType
    public var options: [String] = []
    
    public var title: String {
        return self.options.first ?? defaultTitle.rawValue
    }
    
    public var count: Int {
        return self.options.count
    }
    
    public init(defaultTitle: SearchType) {
        self.defaultTitle = defaultTitle
    }
}
