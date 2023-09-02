//
//  AuthorizationViewModel.swift
//  Authorization
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import AuthenticationServices
import FirebaseDatabase
import FirebaseFirestore
//import GoogleSignIn

public class AuthorizationViewModel: ObservableObject {
    
    
    @Published var userSession: FirebaseAuth.User?
    @Published public var nonce: String  = ""
    @AppStorage("log_status") var log_Status = false
    @AppStorage("Uid") public var uid: String = ""
    @Published public var loginStatus: Bool = false
    @Published var deleteUser: Bool = false
    
    
    public init() {
        self.userSession = Auth.auth().currentUser
        uid = UserDefaults.standard.string(forKey: "Uid") ?? ""
    }
    
    //MARK: - 로그아웃
    public func signOut() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.userSession = nil
            self.loginStatus.toggle()
        }
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //MARK: -  회원 탈퇴
    public func withdrawUser() {
        let firebaseAuth = Auth.auth()
        
        firebaseAuth.currentUser?.delete(completion: { error  in
            self.deleteUser = true
            self.userSession = nil
            print("유저가 삭제 되었습니다 \(String(describing: error?.localizedDescription))")
        })
        
        Auth.auth().currentUser?.reload()
    }
    
    //MARK: -  애플 로그인
    public func appleLogin(credential : ASAuthorizationAppleIDCredential) {
        //MARK:  - 토큰 가져오기
        guard let token = credential.identityToken else {
            debugPrint("[🔥] 파이어 베이스 로그인 에 실패 하였습니다 ")
            return
        }
        //MARK: - 토큰을 문자열 변환
        guard let tokenString = String(data: token, encoding: .utf8) else {
            debugPrint("[🔥]  error with Token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                          idToken: tokenString,
                                                          rawNonce: nonce)
        
        //MARK: - 파이어 베이스 로그인
        
        Auth.auth().signIn(with: firebaseCredential) { (result , error) in
            if let error = error {
                debugPrint("[🔥] 로그인 에 실패 하였습니다 \(error.localizedDescription)")
                return
            }   else {
                guard let user = result?.user else  {return}
                self.userSession = user
                debugPrint("[🔥]  로그인에  성공 하였습니다  \(user)")
                withAnimation(.easeInOut) {
                    self.loginStatus = true
                }
                self.uid = result?.user.uid ?? ""
                let data = ["email" : result?.user.email ?? "" ,
                            "uid" : result?.user.uid ?? ""]
                Firestore.firestore().collection("users")
                    .document(result?.user.uid ?? "")
                    .setData(data) { data in
                        debugPrint("DEBUG : Upload user data : \(String(describing: data))")
                    }
                print("로그인 uid", self.uid)
            }
        }
    }
}
