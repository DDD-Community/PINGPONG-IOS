//
//  SearchUserPrefCodeModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/08.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation


// MARK: - Welcome
public struct SearchUserPrefCodeModel: Codable {
    public let status: Int?
    public let data: SearchUserPrefResponseCodeModel?
    public let message: String?
    
    public init(status: Int?, data: SearchUserPrefResponseCodeModel?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - DataClass
public struct SearchUserPrefResponseCodeModel: Codable {
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

