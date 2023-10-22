//
//  Situation.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Mood: String {
    case support
    case motivation
    case wisdom
    
    public var type: ToppingType {
        switch self {
        case .support:
            return ToppingType(english: "support", korean: "위로", topping: .appleJam)
        case .motivation:
            return ToppingType(english: "motivation", korean: "동기부여", topping: .caramelSyrup)
        case .wisdom:
            return ToppingType(english: "wisdom", korean: "지혜", topping: .chestnut)
        }
    }
    
    var iconImageName: String {
        switch self {
        case .motivation:
            return "carouselMotivationImage"
        case .support:
            return "carouselSupportImage"
        case .wisdom:
            return  "carouselWisdomImage"
        }
    }
    
    public struct ToppingType {
        public let english: String
        public let korean: String
        public let topping: Topping
    }
}
