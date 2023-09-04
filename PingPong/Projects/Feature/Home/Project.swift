//
//  Project.swift
//  Config
//
//  Created by 서원지 on 2023/06/18.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "Home",
    bundleId: .appBundleID(name: "Home"),
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
        .Projcet.Model,
        .Projcet.Profile
        
            
    ],
    sources: ["Sources/**"]
)
