//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/07/26.
//

import Foundation
import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "Core",
    bundleId: .appBundleID(name: "Core"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .Projcet.Home,
        .Projcet.Archive,
        .Projcet.Auth,
        .Projcet.Search,
        .Projcet.Home,
        .Projcet.Archive,
        
            
        
    ],
    sources: ["Sources/**"]
//    resources: ["Resources/**"]
)
