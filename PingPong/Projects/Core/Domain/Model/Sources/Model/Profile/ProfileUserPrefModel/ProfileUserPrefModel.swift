//
//  ProfileUserPrefModel.swift
//  Model
//
//  Created by 서원지 on 11/22/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct ProfileUserPrefModel: Codable {
    public let status: Int?
    public let data: ProfileUserPrefModelResponse?
    public let message: String?
    
    public init(status: Int?, data: ProfileUserPrefModelResponse?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - DataClass
public struct ProfileUserPrefModelResponse: Codable {
    public let regDttm, modDttm: String?
    public let regrID, regrNm, modrID, modrNm: String?
    public let rmk, rowStatus: String?
   public let userPrefID, userID: Int?
   public let flavors, sources: [String]?

    enum CodingKeys: String, CodingKey {
        case regDttm, modDttm
        case regrID = "regrId"
        case regrNm
        case modrID = "modrId"
        case modrNm, rmk, rowStatus
        case userPrefID = "userPrefId"
        case userID = "userId"
        case flavors, sources
    }
    
    public init(regDttm: String?, modDttm: String?, regrID: String?, regrNm: String?, modrID: String?, modrNm: String?, rmk: String?, rowStatus: String?, userPrefID: Int?, userID: Int?, flavors: [String]?, sources: [String]?) {
        self.regDttm = regDttm
        self.modDttm = modDttm
        self.regrID = regrID
        self.regrNm = regrNm
        self.modrID = modrID
        self.modrNm = modrNm
        self.rmk = rmk
        self.rowStatus = rowStatus
        self.userPrefID = userPrefID
        self.userID = userID
        self.flavors = flavors
        self.sources = sources
    }
}
