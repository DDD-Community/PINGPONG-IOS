//
//  Modules.swift
//  MyPlugin
//
//  Created by 서원지 on 11/4/23.
//

import Foundation
import ProjectDescription

public enum ModulePath {
    case feature(Feature)
    case core(Core)
    case domain(Domain)
    case design(Design)
}

// MARK: FeatureModule
public extension ModulePath {
    enum Feature: String, CaseIterable {
        case Archive
        case Auth
        case Core
        case Bake
        case Home
        case OnBoarding
        case Search
        case PayMent
//        case Profile
        
        public static let name: String = "Feature"
    }
}

//MARK: -  CoreMoudule
public extension ModulePath {
    enum Core: String, CaseIterable {
        case Authorization
        case Common
        
        public static let name: String = "Core"
    }
}

//MARK: -  CoreDomainModule
public extension ModulePath {
    enum Domain: String, CaseIterable {
        case API
        case Model
        case Service
        
        public static let name: String = "Domain"
    }
}

public extension ModulePath {
    enum Design: String, CaseIterable {
        case DesignSystem
        
        public static let name: String = "DesignSystem"
    }
}
