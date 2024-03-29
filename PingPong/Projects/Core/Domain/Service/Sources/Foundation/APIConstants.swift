//
//  APIConstants.swift
//  Service
//
//  Created by 서원지 on 2023/07/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Foundation
import API

struct APIConstants{
    
    static let contentType = "content-type"
    static let appPackageName = "App-Package-Name"
    static let authorization =  "Authorization"
    
}

extension APIConstants {
    static var baseHeader: Dictionary<String, String> {
        [ contentType : APIHeaderManger.shared.contentType,
        authorization : "Bearer \(APIHeaderManger.shared.firebaseUid)"
        ]
    }
    
    static var noAuhtHeader: Dictionary<String, String> {
        [ contentType : APIHeaderManger.shared.contentType
        ]
    }
}
