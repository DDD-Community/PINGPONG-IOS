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
    case myPageScraps(userId: String)
    case myPageLikes(userId: String)
}

extension MyPageService: BaseTargetType {
    public var path: String {
        switch self {
        case .myPageUsePref(let userId):
            return "\(PingPongAPIMyPage.myPageEditUserPrefURL)\(userId)"
        case .myPageEditUserPref(let userId, _, _, _):
            return "\(PingPongAPIMyPage.myPageEditUserPrefURL)\(userId)"
        case .myPageScraps(let userId):
            return "\(PingPongAPIMyPage.myPageScrapURL)\(userId)"
        case .myPageLikes(let userId):
            return "\(PingPongAPIMyPage.myPageLikeURL)\(userId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .myPageUsePref:
            return .get
        case .myPageEditUserPref:
            return .put
        case .myPageScraps:
            return .get
        case .myPageLikes:
            return .get
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
            
        case .myPageScraps(let userId):
            let parameters : [String : Any] = [
                "userId": userId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .myPageLikes(let userId):
            let parameters : [String : Any] = [
                "userId": userId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        }
    }
}
