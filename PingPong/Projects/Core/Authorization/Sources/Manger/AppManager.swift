//
//  AppManager.swift
//  Authorization
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import UIKit

public class AppManager: ObservableObject {
    
    public init () {}
    
    public static let shared = AppManager()
    
    public let keyFcMToken = "Key_FCMToken"
    
    public var fcmToken: String {
        get {
            return UserDefaults.standard.string(forKey: keyFcMToken) ?? ""
        }
        
        set(newValue) {
            UserDefaults.standard.setValue(newValue, forKey: keyFcMToken)
            UserDefaults.standard.synchronize()
            
            // Post a notification that the FCM token has been updated.
            let dataDict: [String: String] = ["token": newValue]
            NotificationCenter.default.post(
                name: Notification.Name("Key_FCMToken"),
                object: nil,
                userInfo: dataDict
            )
        }
    }

}
