//
//  CommonCdModel.swift
//  Model
//
//  Created by 서원지 on 10/14/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct CommonCdModel: Codable {
    public let status: Int
    public let data: CommonCdResponseModel
    public let message: String?
    
    public init(status: Int, data: CommonCdResponseModel, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - DataClass
public struct CommonCdResponseModel: Codable {
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

