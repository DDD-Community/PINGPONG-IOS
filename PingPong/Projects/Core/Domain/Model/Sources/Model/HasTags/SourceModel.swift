//
//  Source.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum Source: String {
    case animation = "애니메이션"
    case famous = "유명인"
    case book = "책"
    case drama = "드라마/영화"
    case greatMan = "위인"
    
    public var type: SourceType {
        switch self {
        case .greatMan:
            return SourceType(english: "greatMan", korean: "위인", breadImageName: .breadViewBread)
        case .famous:
            return SourceType(english: "famous", korean: "유명인", breadImageName: .croissant)
        case .animation:
            return SourceType(english: "animation", korean: "애니메이션", breadImageName: .cookie)
        case .drama:
            return SourceType(english: "drama", korean: "드라마/영화", breadImageName: .pancake)
        case .book:
            return SourceType(english: "book", korean: "책", breadImageName: .ciabatta)
        }
    }
    
    public struct SourceType {
        public let english: String
        public let korean: String
        public let breadImageName: Bread
    }
}
