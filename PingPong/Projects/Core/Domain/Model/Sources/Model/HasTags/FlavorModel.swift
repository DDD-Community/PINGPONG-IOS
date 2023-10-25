//
//  FavorModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Flavor: String {
    case sweet
    case salty
    case spicy
    case nutty
    case light
    
    public var type: FlavorType {
        switch self {
        case .light:
            return FlavorType(english: "light",
                              korean: "담백한 맛",
                              ingredent: .corn,
                              smallIconImageName: "lightImage",
                              backgroundImageName1: "cardBGLight1",
                              backgroundImageName2: "cardBGLight2")
        case .nutty:
            return FlavorType(english: "nutty",
                              korean: "고소한 맛",
                              ingredent: .cream,
                              smallIconImageName: "nuttyImage",
                              backgroundImageName1: "cardBGNutty1",
                              backgroundImageName2: "cardBGNutty2")
        case .salty:
            return FlavorType(english: "salty",
                              korean: "짭짤한 맛",
                              ingredent: .cheese,
                              smallIconImageName: "saltyImage",
                              backgroundImageName1: "cardBGSalty1",
                              backgroundImageName2: "cardBGSalty2")
        case .spicy:
            return FlavorType(english: "spicy",
                              korean: "매콤한 맛",
                              ingredent: .jalapeno,
                              smallIconImageName: "spicyImage",
                              backgroundImageName1: "cardBGSpicy1",
                              backgroundImageName2: "cardBGSpicy2")
        case .sweet:
            return FlavorType(english: "sweet",
                              korean: "달콤한 맛",
                              ingredent: .chocolate,
                              smallIconImageName: "sweetImage",
                              backgroundImageName1: "cardBGSweet1",
                              backgroundImageName2: "cardBGSweet2")
        }
    }
    public struct FlavorType {
        public let english: String
        public let korean: String
        public let ingredent: Ingredent
        public let smallIconImageName: String
        
        public let backgroundImageName1: String
        public let backgroundImageName2: String
    }
}

