//
//  MyPageService.swift
//  Service
//
//  Created by 서원지 on 10/4/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import API
import Moya


public enum MyPageService {
    case myPageUsePref(userId: String)
    case myPageEditUserPref(userId: String, userPrefId: String, flavors: [String], sources: [String])
    case myPageLikes(userId: String)
    case deleteLike(likeId: Int)
}

extension MyPageService: BaseTargetType {
    public var path: String {
        switch self {
        case .myPageUsePref(let userId):
            return "\(PingPongAPIMyPage.myPageEditUserPrefURL)\(userId)"
        case .myPageEditUserPref(let userId, _, _, _):
            return "\(PingPongAPIMyPage.myPageEditUserPrefURL)\(userId)"
        case .myPageLikes(let userId):
            return "\(PingPongAPIMyPage.myPageLikeURL)\(userId)"
        case .deleteLike(let likeId):
            return "\(PingPongAPIMyPage.deleteMypageLike)\(likeId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .myPageUsePref:
            return .get
        case .myPageEditUserPref:
            return .put
        case .myPageLikes:
            return .get
        case .deleteLike:
            return .delete
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .myPageUsePref(let userId):
            let parameters : [String : Any] = [
                "userId": userId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .myPageEditUserPref(let userId, let userPrefId, let flavors, let sources):
            let parameters : [String : Any] = [
                "userId": userId,
                "userPrefId": userPrefId,
                "flavors": flavors,
                "sources" : sources
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
            
        case .myPageLikes(let userId):
            let parameters : [String : Any] = [
                "userId": userId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
         
        case .deleteLike(let likeId):
            let parameters : [String : Any] = [
                "likeId": likeId
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
