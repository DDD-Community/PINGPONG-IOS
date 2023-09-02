//
//  Dependency+SPM.swift
//  Config
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    //MARK: - 네트워크 라이브러리
    static let Moya = TargetDependency.external(name: "Moya")
    static let CombineMoya = TargetDependency.external(name: "CombineMoya")
    static let PopupView = TargetDependency.external(name: "PopupView")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let ACarousel = TargetDependency.external(name: "ACarousel")
    static let Inject = TargetDependency.external(name: "Inject")
    static let NukeUI = TargetDependency.external(name: "NukeUI")
    static let FirebaseFirestore = TargetDependency.external(name: "FirebaseFirestore")
    static let FirebaseAuth = TargetDependency.external(name: "FirebaseAuth")
    static let FirebaseDatabase = TargetDependency.external(name: "FirebaseDatabase")
    static let FirebaseMessaging = TargetDependency.external(name: "FirebaseMessaging")
    static let GoogleSignIn = TargetDependency.external(name: "GoogleSignIn")
    static let GoogleSignInSwift = TargetDependency.external(name: "GoogleSignInSwift")
    static let SDWebImageSwiftUI = TargetDependency.external(name: "SDWebImageSwiftUI")
    
    //MARK: - preview 관련
    

}

