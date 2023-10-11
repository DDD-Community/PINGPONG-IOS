//
//  HomeModel.swift
//  Network
//
//  Created by 서원지 on 2023/06/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct HomeRandomQuoteModel: Codable {
   public let status: Int?
    public let data: HomeRandomQuoteResponseModel?
    public let message: String?
    
    public init(status: Int?, data: HomeRandomQuoteResponseModel?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - DataClass
public struct HomeRandomQuoteResponseModel: Codable {
    public let content: [QuoteContent]?
    public let pageable: Pageable?
    public let totalPages, totalElements: Int?
    public let last: Bool?
    public let size, number: Int?
    public let sort: Sort?
    public let numberOfElements: Int?
    public let first, empty: Bool?
    
    public init(content: [QuoteContent]?, pageable: Pageable?, totalPages: Int?, totalElements: Int?, last: Bool?, size: Int?, number: Int?, sort: Sort?, numberOfElements: Int?, first: Bool?, empty: Bool?) {
        self.content = content
        self.pageable = pageable
        self.totalPages = totalPages
        self.totalElements = totalElements
        self.last = last
        self.size = size
        self.number = number
        self.sort = sort
        self.numberOfElements = numberOfElements
        self.first = first
        self.empty = empty
    }
}

// MARK: - Content
public struct QuoteContent: Codable, Identifiable {
    public let id = UUID().uuidString
    public let regDttm, modDttm, regrID: String?
    public let regrNm: String?
    public let modrID: String?
    public let modrNm: String?
    public let rmk: String
    public let rowStatus: String?
    public let quoteID: Int?
    public let content, author, flavor, source: String?
    public let mood: String?
    public let likeYn, scrapYn: Bool?

    enum CodingKeys: String, CodingKey {
        case regDttm, modDttm
        case regrID = "regrId"
        case regrNm
        case modrID = "modrId"
        case modrNm, rmk, rowStatus
        case quoteID = "quoteId"
        case content, author, flavor, source, mood, likeYn, scrapYn
    }
    
    public init(regDttm: String?, modDttm: String?, regrID: String?, regrNm: String?, modrID: String?, modrNm: String?, rmk: String, rowStatus: String?, quoteID: Int?, content: String?, author: String?, flavor: String?, source: String?, mood: String?, likeYn: Bool?, scrapYn: Bool?) {
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

// MARK: - Pageable
public struct Pageable: Codable {
    public let sort: Sort?
    public let offset, pageNumber, pageSize: Int?
    public let paged, unpaged: Bool?
    
    public init(sort: Sort?, offset: Int?, pageNumber: Int?, pageSize: Int?, paged: Bool?, unpaged: Bool?) {
        self.sort = sort
        self.offset = offset
        self.pageNumber = pageNumber
        self.pageSize = pageSize
        self.paged = paged
        self.unpaged = unpaged
    }
}

// MARK: - Sort
public struct Sort: Codable {
    public let empty, sorted, unsorted: Bool?
    
    
    public init(empty: Bool?, sorted: Bool?, unsorted: Bool?) {
        self.empty = empty
        self.sorted = sorted
        self.unsorted = unsorted
    }
}

