//
//  NetworkCode.swift
//  API
//
//  Created by 서원지 on 2023/07/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public enum NetworkCode: String , CustomStringConvertible{
    case success
    case netWorkError
    case serverError
    
    public var status: Int {
        switch self {
        case .success:
            return 200
        case .netWorkError:
            return 400
        case .serverError:
            return 500
        }
    }
    
    public var description: String {
        switch self {
        case .success:
            return "200"
        case .netWorkError:
            return "400"
        case .serverError:
            return "500"
        }
    }
}

