//
//  onBoardingUserPreferenceModel.swift
//  Model
//
//  Created by 서원지 on 2023/08/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation


public struct CommonCodeModel: Codable {
    public let status: Int
    public let data: [commonCodeResponse]?
    public let message: String?
    
    public init(status: Int, data: [commonCodeResponse]?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - WelcomeElement
public struct commonCodeResponse: Codable , Identifiable {
    public let id = UUID().uuidString
    public let commCDTpID: Int?
    public let commCDTpCD, commCDTpNm: String?
    public let commCds: [CommCD]?

    enum CodingKeys: String, CodingKey {
        case commCDTpID = "commCdTpId"
        case commCDTpCD = "commCdTpCd"
        case commCDTpNm = "commCdTpNm"
        case commCds
    }
    
    public init(commCDTpID: Int?, commCDTpCD: String?, commCDTpNm: String?, commCds: [CommCD]?) {
        self.commCDTpID = commCDTpID
        self.commCDTpCD = commCDTpCD
        self.commCDTpNm = commCDTpNm
        self.commCds = commCds
    }
}

// MARK: - CommCD
public struct CommCD: Codable, Identifiable, Hashable {
    public let id = UUID().uuidString
    public let regDttm, modDttm, regrID, regrNm: String?
    public let modrID, modrNm, rmk, rowStatus: String?
    public let commCDID: Int
    public let commCD, commNm: String

    public enum CodingKeys: String, CodingKey {
        case regDttm, modDttm
        case regrID = "regrId"
        case regrNm
        case modrID = "modrId"
        case modrNm, rmk, rowStatus
        case commCDID = "commCdId"
        case commCD = "commCd"
        case commNm
    }
    
    
    public init(regDttm: String?, modDttm: String?, regrID: String?, regrNm: String?, modrID: String?, modrNm: String?, rmk: String?, rowStatus: String?, commCDID: Int, commCD: String, commNm: String) {
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
    }
}






