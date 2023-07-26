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
    
    static let contentType = "Content-Type"
    static let appPackageName = "App-Package-Name"
    static let apikey =  "apikey"
    
}

extension APIConstants {
    static var baseHeader: Dictionary<String, String> {
        [apikey: APIHeaderManger.shared.apiKey,
        appPackageName : APIHeaderManger.shared.appPackageName,
            contentType : APIHeaderManger.shared.contentType
        ]
    }
}
