//
//  FavorModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Flavor: String {
    case sweet = "달콤한 맛"
    case salty = "짭짤한 맛"
    case spicy = "매콤한 맛"
    case nutty = "고소한 맛"
    case light = "담백한 맛"
    
    public var ingredent: Ingredent {
        switch self {
        case .light:
            return .corn
        case .nutty:
            return .cream
        case .salty:
            return .cheese
        case .spicy:
            return .jalapeno
        case .sweet:
            return .chocolate
        }
    }
    
    
}
