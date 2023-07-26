//
//  BaseTargetType.swift
//  Service
//
//  Created by 서원지 on 2023/07/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Foundation
import Moya
import API

public protocol BaseTargetType: TargetType {}


extension BaseTargetType {
    public var baseURL: URL {
        return URL(string: PingPongAPI.baseURL)!
    }
    
    public var headers: [String : String]? {
        return APIConstants.baseHeader
    }
    
}
