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
    case userPreferenceRegister
    case searchUserPreferenceRegister
    case validateName(nickname: String)
}


extension OnBoardingService: BaseTargetType {
    public var path: String {
        switch self {
        case .userPreferenceRegister:
            return PingPongAPIOnBoarding.userPrefURL
        case .searchUserPreferenceRegister:
            return PingPongAPIOnBoarding.searchUserPrefURL
        case .validateName:
            return PingPongAPIOnBoarding.validateNickNameURL
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .userPreferenceRegister:
            return .post
        case .searchUserPreferenceRegister:
            return .get
        case .validateName:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .userPreferenceRegister:
            let parameters : [String : Any] = [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .searchUserPreferenceRegister:
            let parameters : [String : Any] = [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .validateName(let nickname):
            let parameters : [String : Any] = [
                "nickname": nickname
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
