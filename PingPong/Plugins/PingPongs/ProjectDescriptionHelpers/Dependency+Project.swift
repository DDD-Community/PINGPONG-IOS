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
    static let Network = TargetDependency.project(target: "Network", path: .relativeToRoot("Projects/Network"))
    static let DesignSystem = TargetDependency.project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem"))
    static let Home = TargetDependency.project(target: "Home", path: .relativeToRoot("Projects/Feature/Home"))
    static let Profile = TargetDependency.project(target: "Profile", path: .relativeToRoot("Projects/Feature/Profile"))
    static let Search = TargetDependency.project(target: "Search", path: .relativeToRoot("Projects/Feature/Search"))
    static let Authentication = TargetDependency.project(target: "Authentication", path: .relativeToRoot("Projects/Feature/Authentication"))
    static let HomeApp = TargetDependency.project(target: "HomeApp", path: .relativeToRoot("Projects/DemoApp/HomeApp"))
    static let ProfileApp = TargetDependency.project(target: "HomeApp", path: .relativeToRoot("Projects/DemoApp/HomeApp"))
    static let SearchApp = TargetDependency.project(target: "Search", path: .relativeToRoot("Projects/Feature/Search"))
    static let OnBoarding = TargetDependency.project(target: "OnBoarding", path: .relativeToRoot("Projects/Feature/OnBoarding"))
    
}

