//
//  SignUPModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct SignUPModel: Codable {
    public let status: Int?
    public let data: SignUPResponseModel?
    public let message: String?
    
    public init(status: Int?, data: SignUPResponseModel?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - DataClass
public struct SignUPResponseModel: Codable {
    public let id: Int
    public let uid, fcm, email, nickname: String
    public let jobCD, rmk: String

    public enum CodingKeys: String, CodingKey {
        case id, uid, fcm, email, nickname
        case jobCD = "jobCd"
        case rmk
    }
    
    public init(id: Int, uid: String, fcm: String, email: String, nickname: String, jobCD: String, rmk: String) {
        self.id = id
        self.uid = uid
        self.fcm = fcm
        self.email = email
        self.nickname = nickname
        self.jobCD = jobCD
        self.rmk = rmk
    }
}
