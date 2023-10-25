//
//  Ingredent.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Ingredent {
    case chocolate
    case cheese
    case jalapeno
    case cream
    case corn
    
    public var korean: String {
        switch self {
        case .chocolate:
            return "초콜릿"
        case .cheese:
            return "치즈"
        case .jalapeno:
            return "할라피뇨"
        case .cream :
            return "생크림"
        case .corn :
            return "옥수수"
        }
    }
    
    public var imageName: String {
        switch self {
        case .chocolate:
            return "carouselSweetImage"
        case .cheese:
            return "carouselSaltyImage"
        case .jalapeno:
            return "carouselSpicyImage"
        case .cream:
            return "carouselNuttyImage"
        case .corn:
            return "carouselLightImage"
        }
        
    }
}
