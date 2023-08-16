//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/07/26.
//

import ProjectDescription
import MyPlugin


let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "Authorization",
    bundleId: .appBundleID(name: ".Authorization"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .Projcet.DesignSystem,
        .SPM.CombineMoya,
        .SPM.Moya,
        .SPM.Kingfisher,
        .SPM.PopupView,
        .Projcet.Model,
        .Projcet.Service,
        .SPM.FirebaseAuth,
        .SPM.FirebaseFirestore,
        .SPM.FirebaseMessaging,
        .SPM.GoogleSignIn
    ],
    sources: ["Sources/**"]
//    resources: ["Resources/**"]
)


