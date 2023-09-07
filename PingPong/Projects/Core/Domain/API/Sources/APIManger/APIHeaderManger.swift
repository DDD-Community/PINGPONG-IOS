//
//  APIHeaderManger.swift
//  API
//
//  Created by 서원지 on 2023/07/26.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

public class APIHeaderManger {
    public static let shared = APIHeaderManger()
    
    
    @AppStorage("firebaseUid") public var firebaseUid = ""
    public let contentType: String = "application/json"
    
    public init() {
        firebaseUid = UserDefaults.standard.string(forKey: "firebaseUid") ?? ""
        
    }
}
