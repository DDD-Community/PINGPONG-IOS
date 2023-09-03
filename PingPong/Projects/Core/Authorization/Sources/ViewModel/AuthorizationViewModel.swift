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
import Combine
import Model
import CombineMoya
import API
import Moya
import Service

//import GoogleSignIn

public class AuthorizationViewModel: ObservableObject {
    
    
    @Published var userSession: FirebaseAuth.User?
    @Published public var nonce: String  = ""
    @AppStorage("log_status") var log_Status = false
    @AppStorage("Uid") public var uid: String = ""
    @AppStorage("userEmail") public var userEmail: String = ""
    
    @AppStorage("isLogin") public var isLogin: Bool = false
    @AppStorage("isFirstUser") public var isFirstUser: Bool = false
    @AppStorage("completdSignUP") public var completdSignUP: Bool = false
    @Published public var loginStatus: Bool = false
    @Published var deleteUser: Bool = false
    
    
    var userNickNameCheckCancellable: AnyCancellable?
    @Published var userNickNameModel: NickNameValidateModel?
    @Published public var nickNameInvalid: Bool = false
    @Published public var isSignupFail: Bool = false
    
    var signupCancellable: AnyCancellable?
    @Published var signupModel: SignUPModel?
    
    var searchUserIdCancellable: AnyCancellable?
    @AppStorage("userId") public var userid: Int = .zero
    @Published public var userNickName: String = ""
    @Published public var userRmk: String = ""
    
    public init() {
        self.userSession = Auth.auth().currentUser
        uid = UserDefaults.standard.string(forKey: "Uid") ?? ""
        userid = UserDefaults.standard.integer(forKey: "userId")
        isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        isFirstUser = UserDefaults.standard.bool(forKey: "isFirstUser")
        completdSignUP = UserDefaults.standard.bool(forKey: "completdSignUP")
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
                self.userEmail = result?.user.email ?? ""
                
                //MARK: - 토크아이디 
                let currentUser = Auth.auth().currentUser
                currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                  if let error = error {
                    // Handle error
                    return
                  }
                    self.uid = idToken ?? ""
                }
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
    
    //MARK: -  유저 이름 검증
    public func userNickNameValidateToViewModel(_ list: NickNameValidateModel) {
        self.userNickNameModel = list
    }
    
    public func userNickNameValidateRequest(nickname: String) {
        if let cancellable = userNickNameCheckCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<AuthorizationService>(plugins: [MoyaLoggingPlugin()])
        userNickNameCheckCancellable = provider.requestWithProgressPublisher(.validateName(nickname: nickname))
            .compactMap{ $0.response?.data }
            .receive(on: DispatchQueue.main)
            .decode(type: NickNameValidateModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크 에러 ", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.sucess.status {
                    self?.userNickNameValidateToViewModel(model)
                    self?.nickNameInvalid = model.data ?? false
                    print("nickname 검증 ", model)
                } else {
                    self?.userNickNameValidateToViewModel(model)
                    self?.nickNameInvalid = model.data ?? false
                    print("nickname 검증 ", model)
                }
            })
    }
    
    public func signupToViewModel(_ list: SignUPModel) {
        self.signupModel = list
    }
    
    //MARK: -  회원가입
    public func signupPost(uid: String, fcm: String, email: String, nickname: String, jobCd: String, signupSuccessAction: @escaping () -> Void, failSignUPAction: @escaping () -> Void) {
        if let cancellable = signupCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<AuthorizationService>(plugins: [MoyaLoggingPlugin()])
        signupCancellable = provider.requestWithProgressPublisher(.signup(uid: uid, fcm: fcm, email: email, nickname: nickname, jobCd: jobCd))
            .compactMap{ $0.response?.data}
            .decode(type: SignUPModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트 워크 에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if model.status == 200 {
                    self?.signupToViewModel(model)
                    self?.userid = model.data?.id ?? .zero
                    print("회원가입 성공", model)
                    signupSuccessAction()
                } else {
                    self?.signupToViewModel(model)
                    self?.userid = model.data?.id ?? .zero
                    print("회원가입 실패", model)
                    failSignUPAction()
                }
            })
    }
    
    public func searchUserIdToViewModel(_ list: SignUPModel) {
        self.signupModel = list
    }
    
    //MARK: -  uid 로 회원정보 조회
    public func searchUserIdRequest(uid: String) {
        if let cancellable = searchUserIdCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<AuthorizationService>(plugins: [MoyaLoggingPlugin()])
        searchUserIdCancellable = provider.requestWithProgressPublisher(.searchUserByid(id: uid))
            .compactMap{$0.response?.data}
            .decode(type: SignUPModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크 에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.sucess.status {
                    self?.searchUserIdToViewModel(model)
                    print("아이디 조회 성공", model)
                    self?.userNickName = model.data?.nickname ?? ""
                    self?.userRmk = model.data?.rmk ?? ""
                } else {
                    self?.searchUserIdToViewModel(model)
                    print("아이디 조회 성공", model)
                    self?.userNickName = model.data?.nickname ?? ""
                }
            })
    }
    
}
