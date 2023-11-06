//
//  ArchiveModel.swift
//  Model
//
//  Created by 서원지 on 11/4/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct ArchiveModel: Codable {
    public let status: Int?
    public let data: [ArchiveResponseModel]?
    public let message: String?
    
    public init(status: Int?, data: [ArchiveResponseModel]?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - Datum
public struct ArchiveResponseModel: Codable {
    public let regDttm, modDttm: String?
    public let regrID: String?
    public let regrNm: String?
    public let modrID: String?
    public let modrNm: String?
    public let rmk: String?
    public let rowStatus: String?
    public let quoteID: Int?
    public let content: String?
    public let author: String?
    public let flavor: String?
    public let source: String?
    public let mood: String?
    public let likeID: Int?

    enum CodingKeys: String, CodingKey {
        case regDttm, modDttm
        case regrID = "regrId"
        case regrNm
        case modrID = "modrId"
        case modrNm, rmk, rowStatus
        case quoteID = "quoteId"
        case content, author, flavor, source, mood
        case likeID = "likeId"
    }
    
    public init(regDttm: String?, modDttm: String?, regrID: String?, regrNm: String?, modrID: String?, modrNm: String?, rmk: String?, rowStatus: String?, quoteID: Int?, content: String?, author: String?, flavor: String?, source: String?, mood: String?, likeID: Int?) {
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
        self.likeID = likeID
    }
}
