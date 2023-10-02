//
//  Situation.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Situations: String {
    case condolence = "위로"
    case motive = "동기부여"
    case wisdom = "지혜"
    
    public var topping: Topping {
        switch self {
        case .condolence:
            return .appleJam
        case .motive:
            return .caramelSyrup
        case .wisdom:
            return .chestnut
        }
    }
}
