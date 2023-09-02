//
//  AppDelegate.swift
//  PingPong
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import FirebaseCore
import UIKit
import FirebaseMessaging
import Firebase
import Authorization

class AppDelegate: UIViewController, UIApplicationDelegate {
//    var remoteConfig: RemoteConfig!
    
    //MARK: - 앱이 시작 되었을때
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()

        
        return true
    }
    
    
    
    //MARK: -  앱이 삭제 되었을때  로그아웃 처리
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
        
}

