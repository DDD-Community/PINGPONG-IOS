//
//  TargetDependency+Modules.swift
//  MyPlugin
//
//  Created by 서원지 on 11/4/23.
//


import Foundation
import ProjectDescription

// MARK: TargetDependency + Feature
public extension TargetDependency {
    static func feature(implements module: ModulePath.Feature) -> Self {
        return .project(target: module.rawValue, path: .feature(implementation: module))
    }
}

// MARK: TargetDependency + Design
public extension TargetDependency {
    static func design(implements module: ModulePath.Design) -> Self {
        return .project(target: module.rawValue, path: .design(implementation: module))
    }
}

// MARK: TargetDependency + Core
public extension TargetDependency {
    static func core(implements module: ModulePath.Core) -> Self {
        return .project(target: module.rawValue, path: .core(implementation: module))
    }
}


// MARK: TargetDependency + Domain

public extension TargetDependency {
    static func domain(implements module: ModulePath.Domain) -> Self {
        return .project(target: module.rawValue, path: .domain(implementation: module))
    }
}
