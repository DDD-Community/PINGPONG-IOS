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
    name: "Auth",
    bundleId: .appBundleID(name: "Auth"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.Kingfisher,
        .SPM.PopupView,
        .SPM.ACarousel,
        .SPM.Inject,
        .SPM.PopupView,
        .Projcet.DesignSystem,
        .Projcet.Service,
        .Projcet.Authorization
        
        
            
    ],
    sources: ["Sources/**"]
)

