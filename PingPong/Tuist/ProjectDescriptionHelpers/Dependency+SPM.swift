//
//  Dependency+SPM.swift
//  ProjectDescriptionHelpers
//
//  Created by 서원지 on 2023/05/22.
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
    
    //MARK: - preview 관련

}
