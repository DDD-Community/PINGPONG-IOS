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
    static let HomeApp = TargetDependency.project(target: "HomeApp", path: .relativeToRoot("Projects/HomeApp"))
    static let Network = TargetDependency.project(target: "Network", path: .relativeToRoot("Projects/Network"))
    static let Component = TargetDependency.project(target: "Component", path: .relativeToRoot("Projects/Component"))
}

