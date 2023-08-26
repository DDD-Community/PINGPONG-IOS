//
//  onBoardingUserPreferenceModel.swift
//  Model
//
//  Created by 서원지 on 2023/08/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//



public struct onBoardingUserPreferenceModel: Codable {
    public let status: Int
    public let data: [onBoardingUserPreferenceResponse]?
    public let message: String?
    
    public init(status: Int, data: [onBoardingUserPreferenceResponse]?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - WelcomeElement
public struct onBoardingUserPreferenceResponse: Codable {
    public let commCDTpID: Int?
    public let commCDTpCD, commCDTpNm: String?
    public let commCds: [CommCD]

    enum CodingKeys: String, CodingKey {
        case commCDTpID = "commCdTpId"
        case commCDTpCD = "commCdTpCd"
        case commCDTpNm = "commCdTpNm"
        case commCds
    }
    
    public init(commCDTpID: Int?, commCDTpCD: String?, commCDTpNm: String?, commCds: [CommCD]) {
        self.commCDTpID = commCDTpID
        self.commCDTpCD = commCDTpCD
        self.commCDTpNm = commCDTpNm
        self.commCds = commCds
    }
}

// MARK: - CommCD
public struct CommCD: Codable {
    public let commCDID: Int
    public let commCD, commNm: String

    enum CodingKeys: String, CodingKey {
        case commCDID = "commCdId"
        case commCD = "commCd"
        case commNm
    }
    
    public init(commCDID: Int, commCD: String, commNm: String) {
        self.commCDID = commCDID
        self.commCD = commCD
        self.commNm = commNm
    }
}





