//
//  WithDrawModel.swift
//  Model
//
//  Created by 서원지 on 11/19/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct WithDrawModel: Codable {
    public let status: Int?
    public let data: WithDrawResponse?
    public let message: String?
    
    public init(status: Int?, data: WithDrawResponse?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - DataClass
public struct WithDrawResponse: Codable {
}
