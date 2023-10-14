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
            return FlavorType(english: "light", korean: "담백한 맛", ingredentImageName: .corn)
        case .nutty:
            return FlavorType(english: "nutty", korean: "고소한 맛", ingredentImageName: .cream)
        case .salty:
            return FlavorType(english: "salty", korean: "짭짤한 맛", ingredentImageName: .cheese)
        case .spicy:
            return FlavorType(english: "spicy", korean: "매콤한 맛", ingredentImageName: .jalapeno)
        case .sweet:
            return FlavorType(english: "sweet", korean: "달콤한 맛", ingredentImageName: .chocolate)
        }
    }
    public struct FlavorType {
        public let english: String
        public let korean: String
        public let ingredentImageName: Ingredent
    }
}

