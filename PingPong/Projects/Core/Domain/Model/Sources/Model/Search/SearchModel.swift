//
//  SearchModel.swift
//  Model
//
//  Created by 서원지 on 10/22/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct SearchQuoteModel: Codable {
   public let status: Int?
    public let data: SearchQuoteResponseModel?
    public let message: String?
    
    public init(status: Int?, data: SearchQuoteResponseModel?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - DataClass
public struct SearchQuoteResponseModel: Codable {
    public let content: [QuoteContent]
    public let pageable: Pageable?
    public let totalPages, totalElements: Int?
    public let last: Bool?
    public let size, number: Int?
    public let sort: Sort?
    public let numberOfElements: Int?
    public let first, empty: Bool?
    
    public init(content: [QuoteContent], pageable: Pageable?, totalPages: Int?, totalElements: Int?, last: Bool?, size: Int?, number: Int?, sort: Sort?, numberOfElements: Int?, first: Bool?, empty: Bool?) {
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




