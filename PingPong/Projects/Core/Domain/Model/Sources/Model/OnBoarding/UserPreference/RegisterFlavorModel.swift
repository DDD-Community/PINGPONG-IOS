//
//  RegisterFlavorModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct onBoardingRegisterFlavorModel: Codable {
    public let status, data: Int
    public let message: String?
    
    public init(status: Int, data: Int, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

