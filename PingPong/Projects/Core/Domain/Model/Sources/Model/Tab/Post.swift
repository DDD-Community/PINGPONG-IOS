//
//  Post.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct Post: Identifiable, Equatable {
     public static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.title == rhs.title
    }
    
    public var id = UUID().uuidString
    public var stageNum : Int
    public var hashtags: Hashtags
    public var image: String
    public var title: String
    public var sources: String
    public var isBookrmark: Bool
    
    public init(id: String = UUID().uuidString, stageNum: Int, hashtags: Hashtags, image: String, title: String, sources: String, isBookrmark: Bool) {
        self.id = id
        self.stageNum = stageNum
        self.hashtags = hashtags
        self.image = image
        self.title = title
        self.sources = sources
        self.isBookrmark = isBookrmark
    }
}
