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
    static let API = TargetDependency.project(target: "API", path: .relativeToRoot("Projects/Core/Domain/API"))
    static let Service = TargetDependency.project(target: "Service", path: .relativeToRoot("Projects/Core/Domain/Service"))
    
    static let Model = TargetDependency.project(target: "Model", path: .relativeToRoot("Projects/Core/Domain/Model"))
    static let Authorization = TargetDependency.project(target: "Authorization", path: .relativeToRoot("Projects/Core/Authorization"))
    static let DesignSystem = TargetDependency.project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem"))
    static let Home = TargetDependency.project(target: "Home", path: .relativeToRoot("Projects/Feature/Home"))
    static let Profile = TargetDependency.project(target: "Profile", path: .relativeToRoot("Projects/Feature/Profile"))
    static let Search = TargetDependency.project(target: "Search", path: .relativeToRoot("Projects/Feature/Search"))
    static let Auth = TargetDependency.project(target: "Auth", path: .relativeToRoot("Projects/Feature/Auth"))
    static let HomeApp = TargetDependency.project(target: "HomeApp", path: .relativeToRoot("Projects/DemoApp/HomeApp"))
    static let ProfileApp = TargetDependency.project(target: "HomeApp", path: .relativeToRoot("Projects/DemoApp/HomeApp"))
    static let SearchApp = TargetDependency.project(target: "Search", path: .relativeToRoot("Projects/Feature/Search"))
    static let OnBoarding = TargetDependency.project(target: "OnBoarding", path: .relativeToRoot("Projects/Feature/OnBoarding"))
    static let Core = TargetDependency.project(target: "Core", path: .relativeToRoot("Projects/Feature/Core"))
    
}

