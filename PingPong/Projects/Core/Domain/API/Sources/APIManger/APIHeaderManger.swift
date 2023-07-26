//
//  APIHeaderManger.swift
//  API
//
//  Created by 서원지 on 2023/07/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public class APIHeaderManger {
    public static let shared = APIHeaderManger()
    
    public init() {}
    
    
    
   public let apiKey: String = "F6E5D7EF-9A8C-4DAE-9BF5-C9962146F4C8"
    public let appPackageName: String = "com.dym.chaevi.main"
    public let contentType: String = "application/json"
}
