//
//  CommonType.swift
//  Model
//
//  Created by 서원지 on 10/14/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum CommonType: CaseIterable , CustomStringConvertible {
    case flavor
    case source
    case mood
    
    public var description: String {
        switch self {
        case .flavor:
            return "flavor"
        case .source:
            return "source"
        case .mood:
            return "mood"
        }
    }
}
