//
//  Bread.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Bread {
    case plainBread
    case croissant
    case pancake
    case cookie
    case ciabatta
    
    public var korean: String {
        switch self {
        case .plainBread:
            return "식빵"
        case .croissant:
            return "크로아상"
        case .pancake:
            return "팬케이크"
        case .cookie:
            return "쿠키"
        case .ciabatta:
            return "치아바타"
        }
    }
    
    public var imageName: String {
        switch self {
        case .plainBread:
            return "carouselGreatmanImage"
        case .croissant:
            return "carouselCeleImage"
        case .pancake:
            return "carouselDramaImage"
        case .cookie:
            return "carouselAnimeImage"
        case .ciabatta:
            return "carouselBookImage"
        }
    }
}
