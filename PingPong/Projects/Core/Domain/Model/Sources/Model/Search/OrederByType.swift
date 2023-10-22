//
//  OrederByType.swift
//  Model
//
//  Created by 서원지 on 10/22/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum OrederByType: CaseIterable, CustomStringConvertible {
    case ASC
    case DESC
    
    
    public var description: String {
        switch self {
        case .ASC:
            return "ASC"
        case .DESC:
            return "DESC"
        }
    }
}
