//
//  Post.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct CardInfomation: Identifiable, Equatable {
     public static func == (lhs: CardInfomation, rhs: CardInfomation) -> Bool {
         return lhs.id == rhs.id
    }
    
    public let id = UUID().uuidString
    public var stageNum : Int
    public var hashtags: Hashtags
    public var image: String
    public var title: String
    public var sources: String
    public var isBookrmark: Bool
    
    public init(stageNum: Int, hashtags: Hashtags, image: String, title: String, sources: String, isBookrmark: Bool) {
        self.stageNum = stageNum
        self.hashtags = hashtags
        self.image = image
        self.title = title
        self.sources = sources
        self.isBookrmark = isBookrmark
    }
}
