//
//  AuthorizationService.swift
//  Service
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Moya
import API

public enum AuthorizationService {
    case signup(uid: String, fcm: String, email: String, nickname: String, jobCd: String)
    case validateUid(uid: String)
    case validateName(nickname: String)
    case searchUserByUid(uid: String)
    case searchUserByid(id: String)
}

extension AuthorizationService: BaseTargetType {
    public var path: String {
        switch self {
        case .signup:
            return PingPongAPIAuthorization.signupURL
        case .validateUid:
            return PingPongAPIAuthorization.validatUidURL
        case .validateName:
            return PingPongAPIAuthorization.validateNickNameURL
        case .searchUserByUid:
            return PingPongAPIAuthorization.searchUserByUidURL
        case .searchUserByid:
            return PingPongAPIAuthorization.searchUserByidURL
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signup:
            return .post
        case .validateUid:
            return .get
        case .validateName:
            return .get
        case .searchUserByUid:
            return .get
        case .searchUserByid:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .signup(let uid, let fcm, let email, let nickname, let jobCd):
            let parameters : [String : Any] = [
                "uid": uid,
                "fcm": fcm,
                "email": email,
                "nickname": nickname,
                "jobCd": jobCd
            ]
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .validateUid(let uid):
            let parameters : [String : Any] = [
                "uid": uid
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .validateName(let nickname):
            let parameters : [String : Any] = [
                "nickname": nickname
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .searchUserByUid(let uid):
            let parameters : [String : Any] = [
                "uid": uid
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .searchUserByid(let id):
            let parameters : [String : Any] = [:
//                "id": id
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
