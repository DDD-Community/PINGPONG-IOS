//
//  Path+Modules.swift
//  MyPlugin
//
//  Created by 서원지 on 11/4/23.
//

import Foundation

import Foundation
import ProjectDescription

// MARK: ProjectDescription.Path + Feature
public extension ProjectDescription.Path {
    static var feature: Self {
        return .relativeToRoot("Projects/\(ModulePath.Feature.name)")
    }
    
    static func feature(implementation module: ModulePath.Feature) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Feature.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Core
public extension ProjectDescription.Path {
    static var core: Self {
        return .relativeToRoot("Projects/\(ModulePath.Core.name)")
    }
    
    static func core(implementation module: ModulePath.Core) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Core.name)/\(module.rawValue)")
    }
}


// MARK: ProjectDescription.Path + DesignSystem

public extension ProjectDescription.Path {
    static var design: Self {
        return .relativeToRoot("Projects/\(ModulePath.Design.name)")
    }
    
    static func design(implementation module: ModulePath.Design) -> Self {
        return .relativeToRoot("Projects/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Domain

public extension ProjectDescription.Path {
    static var domain: Self {
        return .relativeToRoot("Projects/\(ModulePath.Core.name)/\(ModulePath.Domain.name)")
    }
    
    static func domain(implementation module: ModulePath.Domain) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Core.name)/\(ModulePath.Domain.name)/\(module.rawValue)")
    }
}
