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
        .feature(implements: .Home),
        .feature(implements: .Archive),
        .feature(implements: .Auth),
        .feature(implements: .Search),
        
        .SPM.PopupView
        
            
        
    ],
    sources: ["Sources/**"]
//    resources: ["Resources/**"]
)
