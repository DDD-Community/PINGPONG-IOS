//
//  Situation.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Mood: String {
    case condolence = "위로"
    case motive = "동기부여"
    case wisdom = "지혜"
    
    public var type: ToppingType {
        switch self {
        case .condolence:
            return ToppingType(english: "condolence", korean: "위로", toppingImageName: .appleJam)
        case .motive:
            return ToppingType(english: "motive", korean: "동기부여", toppingImageName: .caramelSyrup)
        case .wisdom:
            return ToppingType(english: "wisdom", korean: "지혜", toppingImageName: .chestnut)
        }
    }
    
    public struct ToppingType {
        public let english: String
        public let korean: String
        public let toppingImageName: Topping
    }
}
