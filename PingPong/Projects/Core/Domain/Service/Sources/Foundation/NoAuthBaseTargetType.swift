//
//  NoAuthBaseTargetType.swift
//  Service
//
//  Created by 서원지 on 12/4/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Moya
import API

public protocol NoAuthBaseTargetType: TargetType {}


extension NoAuthBaseTargetType {
    public var baseURL: URL {
        return URL(string: PingPongAPI.baseURL)!
    }
    
    public var headers: [String : String]? {
        return APIConstants.noAuhtHeader
    }
    
}
