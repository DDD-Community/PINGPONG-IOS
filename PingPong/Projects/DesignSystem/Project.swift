//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "DesignSystem",
    bundleId: .appBundleID(name: "DesignSystem"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.SDWebImageSwiftUI,
        .domain(implements: .Model)
            
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"]
)

