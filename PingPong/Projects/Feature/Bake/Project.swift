//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 10/5/23.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "Bake",
    bundleId: .appBundleID(name: "Bake"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .design(implements: .DesignSystem),
        .domain(implements: .Service),
        .domain(implements: .Model),
        .core(implements: .Common),
        .core(implements: .Authorization),
        
        .SPM.PopupView,
        .SPM.Moya,
        .SPM.CombineMoya
        
    ],
    sources: ["Sources/**"]
)

