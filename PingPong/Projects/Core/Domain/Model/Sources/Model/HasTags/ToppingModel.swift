//
//  Topping.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Topping {
    case appleJam
    case caramelSyrup
    case chestnut
    
    public var korean: String {
        switch self {
        case .appleJam:
            return "사과잼"
        case .caramelSyrup:
            return "캬라멜시럽"
        case .chestnut:
            return "밤"
        }
    }
    
    public var imageName: String {
        switch self {
        case .appleJam:
            return "carouselSupportImage"
        case .caramelSyrup:
            return "carouselMotivationImage"
        case .chestnut:
            return "carouselWisdomImage"
        }
    }
}
