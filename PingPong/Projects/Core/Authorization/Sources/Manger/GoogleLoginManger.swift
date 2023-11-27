//
//  LoginManger.swift
//  Authorization
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//


//import SwiftUI
//import CryptoKit
//import Firebase
//
//
//struct GoogleLoginManger {
//    static let shared = GoogleLoginManger()
//
//    func getRootViewController()-> UIViewController{
//        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
//            return .init()
//        }
//        guard let root = screen.windows.first?.rootViewController else{
//            return .init()
//        }
//        return root
//    }
//
//    func appDeleteSignout() {
//        do  {
//            try Auth.auth().signOut()
//        } catch let error {
//            print("error signing out: \(error.localizedDescription)")
//        }
//    }
//
//}
