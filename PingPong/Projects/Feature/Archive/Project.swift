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
        .SPM.PopupView,
        .Projcet.DesignSystem,
        .Projcet.Service,
        .Projcet.Model,
        .SPM.Moya,
        .SPM.CombineMoya,
        .Projcet.Authorization,
        .Projcet.Common,
        .Projcet.Bake
        
            
        
        
    ],
    sources: ["Sources/**"]
)
