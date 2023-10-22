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
        .SPM.PopupView,
        .Projcet.DesignSystem,
        .Projcet.Service,
        .Projcet.Model,
        .SPM.Moya,
        .SPM.CombineMoya,
        .Projcet.Common,
        .Projcet.Authorization
        
            
        
        
    ],
    sources: ["Sources/**"]
)

