//
//  SearchUserPrefCodeModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/08.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

import Foundation

// MARK: - Welcome
public struct SearchUserPrefCodeModel: Codable {
    public let status: Int
    public let data: SearchUserPrefResponseCodeModel
    public let message: String?
    
    public init(status: Int, data: SearchUserPrefResponseCodeModel, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - DataClass
public struct SearchUserPrefResponseCodeModel: Codable {
    public let commCDTpID: Int
    public let commCDTpCD, commCDTpNm: String
    public let commCds: [CommCD]

    enum CodingKeys: String, CodingKey {
        case commCDTpID = "commCdTpId"
        case commCDTpCD = "commCdTpCd"
        case commCDTpNm = "commCdTpNm"
        case commCds
    }
    
    public init(commCDTpID: Int, commCDTpCD: String, commCDTpNm: String, commCds: [CommCD]) {
        self.commCDTpID = commCDTpID
        self.commCDTpCD = commCDTpCD
        self.commCDTpNm = commCDTpNm
        self.commCds = commCds
    }
}

// MARK: - CommCD
public struct CommCD: Codable {
    public let regDttm, modDttm, regrID, regrNm: JSONNull?
    public let modrID, modrNm, rmk, rowStatus: JSONNull?
    public let commCDID: Int
    public let commCD, commNm: String
    public let sortSeq: Int
    public let useYn: Bool

    enum CodingKeys: String, CodingKey {
        case regDttm, modDttm
        case regrID = "regrId"
        case regrNm
        case modrID = "modrId"
        case modrNm, rmk, rowStatus
        case commCDID = "commCdId"
        case commCD = "commCd"
        case commNm, sortSeq, useYn
    }
    
    public init(regDttm: JSONNull?, modDttm: JSONNull?, regrID: JSONNull?, regrNm: JSONNull?, modrID: JSONNull?, modrNm: JSONNull?, rmk: JSONNull?, rowStatus: JSONNull?, commCDID: Int, commCD: String, commNm: String, sortSeq: Int, useYn: Bool) {
        self.regDttm = regDttm
        self.modDttm = modDttm
        self.regrID = regrID
        self.regrNm = regrNm
        self.modrID = modrID
        self.modrNm = modrNm
        self.rmk = rmk
        self.rowStatus = rowStatus
        self.commCDID = commCDID
        self.commCD = commCD
        self.commNm = commNm
        self.sortSeq = sortSeq
        self.useYn = useYn
    }
}
