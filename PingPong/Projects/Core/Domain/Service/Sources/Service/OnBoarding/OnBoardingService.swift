//
//  OnBoardingService.swift
//  Service
//
//  Created by 서원지 on 2023/08/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import API
import Moya

public enum OnBoardingService {
    case userPreferenceRegister(userId: Int, flavors: [String], sources: [String])
    case searchUserPreferenceRegister
}


extension OnBoardingService: BaseTargetType {
    public var path: String {
        switch self {
        case .userPreferenceRegister(let userId, _ , _):
            return "\(PingPongAPIOnBoarding.userPrefURL)\(userId)"
        case .searchUserPreferenceRegister:
            return PingPongAPIOnBoarding.searchUserPrefURL
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .userPreferenceRegister:
            return .post
        case .searchUserPreferenceRegister:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .userPreferenceRegister(_, let flavors, let sources):
            let parameters : [String : Any] = [
                "flavors": flavors,
                "sources": sources
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .searchUserPreferenceRegister:
            let parameters : [String : Any] = [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
