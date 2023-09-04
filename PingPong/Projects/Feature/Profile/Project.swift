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
    name: "Profile",
    bundleId: .appBundleID(name: "Profile"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.Kingfisher,
        .SPM.PopupView,
        .SPM.ACarousel,
        .SPM.PopupView,
        .Projcet.DesignSystem,
        .SPM.Inject,
        .Projcet.Auth,
        .Projcet.Service,
        .Projcet.Model,
        .Projcet.Authorization
    ],
    sources: ["Sources/**"]
)
