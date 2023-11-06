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
         return lhs.qouteId == rhs.qouteId
    }
    
    public let id = UUID().uuidString
    public var qouteId : Int
    public var hashtags: Hashtags
    public var image: String
    public var title: String
    public var author: String
    public var isBookrmark: Bool
    public var likeId: Int?
    
    public init(qouteId: Int, hashtags: Hashtags, image: String, title: String, sources: String, isBookrmark: Bool, likeId: Int?) {
        self.qouteId = qouteId
        self.hashtags = hashtags
        self.image = image
        self.title = title
        self.author = sources
        self.isBookrmark = isBookrmark
        self.likeId = likeId
    }
}
