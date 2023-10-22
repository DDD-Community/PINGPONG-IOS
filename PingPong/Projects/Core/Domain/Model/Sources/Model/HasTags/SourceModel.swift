//
//  Source.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Source: String {
    case anime
    case celeb
    case book
    case film
    case greatman 
    
    public var type: SourceType {
        switch self {
        case .greatman:
            return SourceType(english: "greatMan", korean: "위인", bread: .plainBread, smallIconImageName: "greatmanImage")
        case .celeb:
            return SourceType(english: "famous", korean: "유명인", bread: .croissant, smallIconImageName: "celeImage")
        case .anime:
            return SourceType(english: "animation", korean: "애니메이션", bread: .cookie, smallIconImageName: "animeImage")
        case .film:
            return SourceType(english: "film", korean: "드라마/영화", bread: .pancake, smallIconImageName: "filmImage")
        case .book:
            return SourceType(english: "book", korean: "책", bread: .ciabatta, smallIconImageName: "bookImage")
        }
    }
    
    public struct SourceType {
        public let english: String
        public let korean: String
        public let bread: Bread
        
        public let smallIconImageName: String
    }
}
