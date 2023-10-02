//
//  Source.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Sources: String {
    case animation = "애니메이션"
    case famous = "유명인"
    case book = "책"
    case drama = "드라마/영화"
    case greatMan = "위인"
    
    public var bread: Bread {
        switch self {
        case .greatMan:
            return .breadViewBread
        case .famous:
            return .croissant
        case .animation:
            return .cookie
        case .drama:
            return .pancake
        case .book:
            return .ciabatta
        }
    }
}
