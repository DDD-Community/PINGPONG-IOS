//
//  Dependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 서원지 on 2023/05/22.
//

import ProjectDescription

public extension TargetDependency {
    enum Projcet {}
}

public extension TargetDependency.Projcet {
    static let Network = TargetDependency.project(target: "Network", path: .relativeToRoot("Projects/Network"))
    static let Component = TargetDependency.project(target: "Component", path: .relativeToRoot("Projects/Component"))
}
