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
    case signup(token: String, fcm: String, email: String, nickname: String, jobCd: String)
    case validateUid(uid: String)
    case validateName(nickname: String)
    case searchUserByUid(uid: String)
    case searchUserByid(id: String)
    case changeUserInfo(userId: String)
    case loginWithEmail(email: String)
    case withDraw(userId: String, reason: String)
}

extension AuthorizationService: BaseTargetType {
    public var path: String {
        switch self {
        case .signup:
            return PingPongAPIAuthorization.signupURL
        case .validateUid(let uid):
            return "\(PingPongAPIAuthorization.validatUidURL)/\(uid)"
        case .validateName:
            return PingPongAPIAuthorization.validateNickNameURL
        case .searchUserByUid(let uid):
            return "\(PingPongAPIAuthorization.searchUserByUidURL)/\(uid)"
        case .searchUserByid(let id):
            return "\(PingPongAPIAuthorization.searchUserByidURL)/\(id)"
        case .changeUserInfo(let userId):
            return "\(PingPongAPIAuthorization.userInfoURL)\(userId)"
        case .loginWithEmail(let email):
            return "\(PingPongAPIAuthorization.loginEmailURL)\(email)"
        case .withDraw(let userId, _):
            return "\(PingPongAPIAuthorization.withdrawalURL)\(userId)"
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
        case .changeUserInfo:
            return .put
        case .loginWithEmail:
            return .get
        case .withDraw:
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .signup(let token, let fcm, let email, let nickname, let jobCd):
            let parameters : [String : Any] = [
                "token": token,
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
            
        case .changeUserInfo(let userId):
            let parameters : [String : Any] = [
                "userId": userId
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .loginWithEmail(_):
            let parameters : [String : Any] = [
//                "email": email
                :
            ]
            return .requestParameters(parameters: parameters, encoding:  URLEncoding.queryString)
            
        case .withDraw(_ ,let reason):
            let parameters : [String : Any] = [
//                "email": email
                "reason": reason
            ]
            return .requestParameters(parameters: parameters, encoding:  JSONEncoding.default)
            
        }
    }
}
