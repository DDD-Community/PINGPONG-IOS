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
        .SPM.Inject,
        .SPM.PopupView,
        .Projcet.DesignSystem,
        .Projcet.Model,
        .Projcet.Service,
        .SPM.Moya,
        .SPM.CombineMoya,
        .SPM.FirebaseAuth,
        .Projcet.Authorization,
        .Projcet.Core
            
        
    ],
    sources: ["Sources/**"]
    
)
