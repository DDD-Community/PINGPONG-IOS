//
//  SearchService.swift
//  Service
//
//  Created by 서원지 on 2023/09/06.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Moya
import API

public enum SearchService {
    case searchQuote(page: Int, sizePerPage: Int, keyword: String, flavors: [String], sources: [String], moods: [String], orderBy: String)
    case searchCommCode(commCdTpCd: String)
}

extension SearchService: BaseTargetType {
    public var path: String {
        switch self {
        case .searchQuote: 
            return PingPongAPISearch.searchQuote
        case .searchCommCode(let commCdTpCd):
            return "\(PingPongAPISearch.searchCommonCode)\(commCdTpCd)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .searchQuote:
            return .post
        case .searchCommCode:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case  .searchQuote(let page, let sizePerPage, let keyword, let flavors, let sources, let moods, let orderBy):
            let parameters : [String : Any] = [
                "page": page,
                "sizePerPage": sizePerPage,
                "keyword": keyword,
                "flavors": flavors,
                "sources": sources,
                "moods": moods,
                "orderBy": orderBy
            ]
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .searchCommCode(_):
            let parameters : [String : Any] = [
//                "commCdTpCd": commCdTpCd
                :
               
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}


