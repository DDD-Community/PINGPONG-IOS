//
//  Dependency+Project.swift
//  Config
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription

public extension TargetDependency {
    enum Projcet {}
}

public extension TargetDependency.Projcet {
    
    //MARK: -  공용 viewModel
    static let Common = TargetDependency.project(target: "Common", path: .relativeToRoot("Projects/Core/Common"))
    
    //MARK: -  회원가입 및  소셜  인증  모듈
    static let Authorization = TargetDependency.project(target: "Authorization", path: .relativeToRoot("Projects/Core/Authorization"))
    
    //MARK: -  Domain
    static let API = TargetDependency.project(target: "API", path: .relativeToRoot("Projects/Core/Domain/API"))
    static let Service = TargetDependency.project(target: "Service", path: .relativeToRoot("Projects/Core/Domain/Service"))
    static let Model = TargetDependency.project(target: "Model", path: .relativeToRoot("Projects/Core/Domain/Model"))
    
   //MARK: -  디자인 시스템
    static let DesignSystem = TargetDependency.project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem"))
    
    //MARK: -  Feature에서 각 씬 모듈(Core 안에는 다들어가 있습니다.)
    static let Core = TargetDependency.project(target: "Core", path: .relativeToRoot("Projects/Feature/Core"))
    static let OnBoarding = TargetDependency.project(target: "OnBoarding", path: .relativeToRoot("Projects/Feature/OnBoarding"))
    static let Home = TargetDependency.project(target: "Home", path: .relativeToRoot("Projects/Feature/Home"))
    static let Archive = TargetDependency.project(target: "Archive", path: .relativeToRoot("Projects/Feature/Archive"))
    static let Search = TargetDependency.project(target: "Search", path: .relativeToRoot("Projects/Feature/Search"))
    static let Auth = TargetDependency.project(target: "Auth", path: .relativeToRoot("Projects/Feature/Auth"))
    
     
   
    
    
}

