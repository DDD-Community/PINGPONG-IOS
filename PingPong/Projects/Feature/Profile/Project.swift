//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/18.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeModule(
    name: "Profile",
    bundleId: .appBundleID(name: "Profile"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.Kingfisher,
        .SPM.PopupView,
        .SPM.ACarousel,
        .SPM.Inject,
        .SPM.PopupView,
        .Projcet.Component,
        .Projcet.Network,
        .Projcet.Authentication
            
        
            
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"]
)
