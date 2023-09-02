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

class AppDelegate: UIViewController, UIApplicationDelegate{
    
    //MARK: - 앱이 시작 되었을때
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
//
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: { _, _ in }
//            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        
        
        // 푸시 포그라운드 설정
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
}


extension AppDelegate : MessagingDelegate , UNUserNotificationCenterDelegate{
    
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("AppDelegate - 파베 토큰을 받았다.")
        print("AppDelegate - Firebase registration token: \(String(describing: fcmToken))")
        guard let currentToken = Messaging.messaging().fcmToken else { return }
        
        if currentToken != fcmToken {
            Messaging.messaging().token { token, error in
                if let error = error {
                    print("Error fetching FCM registration token: \(error.localizedDescription)")
                } else {
                    print("파이어 베이스 토큰: \(token)")
                    if let token = token {
                        AppManager.shared.fcmToken = token
                    }
                }
            }
        } else if let newToken = fcmToken {
            AppManager.shared.fcmToken = newToken
            print("토근 재생성 \(newToken)")
        }
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("Key_FCMToken"), object: nil, userInfo: dataDict)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("devoice token = \(deviceToken)")
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        print("token = \(deviceTokenString)")
    }
    // 앱이 백그라운드나 종료되어 있는 상태에서 푸시 데이터 처리
     func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("PushNotificationManager - willPresentNotification = \(notification.request.content.userInfo)")
        
        let userInfo = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler([.banner, .sound, .badge])
    }
    
     func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("PushNotificationManager - didReceiveNotification = \(response.notification.request.content.userInfo)")
        
        let userInfo = response.notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
         print("딥링크 푸쉬 알림 \(userInfo)")
         
        completionHandler()
    }
}
