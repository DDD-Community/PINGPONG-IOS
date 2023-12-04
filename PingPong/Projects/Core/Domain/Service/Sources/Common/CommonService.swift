//
//  CommonService.swift
//  Service
//
//  Created by 서원지 on 12/4/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Moya
import API

public enum CommonService {
    case searchCommCode(commCdTpCd: String)
}


extension CommonService: NoAuthBaseTargetType {
    public var path: String {
        switch self {
        case .searchCommCode(let commCdTpCd):
            return "\(PingPongAPISearch.searchCommonCode)\(commCdTpCd)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .searchCommCode:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .searchCommCode(_):
            let parameters : [String : Any] = [
                :
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
