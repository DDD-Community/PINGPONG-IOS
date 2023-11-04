//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/18.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "Archive",
    bundleId: .appBundleID(name: "Archive"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .design(implements: .DesignSystem),
        .domain(implements: .Service),
        .domain(implements: .Model),
        .core(implements: .Authorization),
        .core(implements: .Common),
        .feature(implements: .Bake),
        
        .SPM.PopupView,
        .SPM.Moya,
        .SPM.CombineMoya
        
            
        
        
    ],
    sources: ["Sources/**"]
)
