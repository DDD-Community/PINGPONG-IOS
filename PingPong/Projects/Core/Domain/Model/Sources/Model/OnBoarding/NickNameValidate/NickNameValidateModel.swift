//
//  NickNameValidateModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct NickNameValidateModel: Codable {
    public let status: Int
    public let data: Bool
    public let message: String?
    
    public init(status: Int, data: Bool, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}
