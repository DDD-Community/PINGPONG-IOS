//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/25.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "OnBoarding",
    bundleId: .appBundleID(name: ".OnBoarding"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .design(implements: .DesignSystem),
        .domain(implements: .Model),
        .domain(implements: .Service),
        .core(implements: .Authorization),
        .core(implements: .Common),
        .feature(implements: .Core),
        
        .SPM.Inject,
        .SPM.PopupView,
        .SPM.Moya,
        .SPM.CombineMoya,
//        .SPM.GoogleSignInSwift
        
    ],
    sources: ["Sources/**"]
    
)
