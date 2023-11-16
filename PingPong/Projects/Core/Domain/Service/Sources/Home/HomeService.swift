//
//  HomeService.swift
//  Network
//
//  Created by 서원지 on 2023/06/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Moya
import API

public enum HomeService  {
    case homeRandomQuote(page: Int, sizePerPage: Int, userId: String)
    case homeBakeQuote(userId: String, flavor: String, source: String, mood: String)
    case homeLike(userId: String, quoteId: Int)
    case homeQuoteScrap(userId: String, quoteId: Int)
}


extension HomeService: BaseTargetType {
    public var path: String {
        switch self {
        case .homeRandomQuote:
            return PingPongAPIHome.homeRandomQuote
        case .homeBakeQuote:
            return PingPongAPIHome.homeBakeQuote
        case .homeLike:
            return PingPongAPIHome.homeLike
        case .homeQuoteScrap:
            return PingPongAPIHome.homeScarp
            
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .homeRandomQuote:
            return .get
        case .homeBakeQuote:
            return .get
        case .homeLike:
            return .post
        case .homeQuoteScrap:
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .homeRandomQuote(let page, let sizePerPage, let userId):
            let parameters : [String : Any] = [
                "page": page,
                "sizePerPage": sizePerPage,
                "userId": userId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .homeBakeQuote(let userId, let flavor, let source, let mood):
            let parameters : [String : Any] = [
                "userId": userId,
                "flavor": flavor,
                "source": source,
                "mood": mood
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .homeLike(let userId, let quoteId):
            let parameters : [String : Any] = [
                "userId": userId,
                "quoteId": quoteId
               
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .homeQuoteScrap(let userId, let quoteId):
            let parameters : [String : Any] = [
                "userId": userId,
                "quoteId": quoteId
               
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        }
    }
}
