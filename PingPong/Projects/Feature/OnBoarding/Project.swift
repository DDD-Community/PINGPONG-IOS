//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/25.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeModule(
    name: "OnBoarding",
    bundleId: .appBundleID(name: ".OnBoarding"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.Inject,
        .SPM.PopupView,
        .Projcet.DesignSystem,
    ],
    sources: ["Sources/**"]
    
)
