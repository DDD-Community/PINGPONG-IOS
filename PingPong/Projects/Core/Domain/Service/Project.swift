//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/07/26.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "Service",
    bundleId: .appBundleID(name: ".Service"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.CombineMoya,
        .SPM.Moya,
        .sdk(name: "OSLog", type: .framework),
        .domain(implements: .API)
        
            
    ],
    sources: ["Sources/**"]
)
