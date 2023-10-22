//
//  SearchModel.swift
//  Model
//
//  Created by 서원지 on 10/22/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct SearchModel: Codable {
    public let regDttm, modDttm, regrID, regrNm: String
    public let modrID, modrNm, rmk, rowStatus: String
    public let quoteID: Int
    public let content, author, flavor, source: String
    public let mood: String
    public let likeYn, scrapYn: Bool

    enum CodingKeys: String, CodingKey {
        case regDttm, modDttm
        case regrID = "regrId"
        case regrNm
        case modrID = "modrId"
        case modrNm, rmk, rowStatus
        case quoteID = "quoteId"
        case content, author, flavor, source, mood, likeYn, scrapYn
    }
    
    public init(regDttm: String, modDttm: String, regrID: String, regrNm: String, modrID: String, modrNm: String, rmk: String, rowStatus: String, quoteID: Int, content: String, author: String, flavor: String, source: String, mood: String, likeYn: Bool, scrapYn: Bool) {
        self.regDttm = regDttm
        self.modDttm = modDttm
        self.regrID = regrID
        self.regrNm = regrNm
        self.modrID = modrID
        self.modrNm = modrNm
        self.rmk = rmk
        self.rowStatus = rowStatus
        self.quoteID = quoteID
        self.content = content
        self.author = author
        self.flavor = flavor
        self.source = source
        self.mood = mood
        self.likeYn = likeYn
        self.scrapYn = scrapYn
    }
}
