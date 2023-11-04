//
//  DeleteModel.swift
//  Model
//
//  Created by 서원지 on 11/5/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct DeleteModel: Codable {
    public let status: Int?
    public let data: DeleteResponseModel?
    public let message: String?
    
    public init(status: Int?, data: DeleteResponseModel?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}

// MARK: - DataClass
public struct DeleteResponseModel: Codable {
    
    public init() {}
}
