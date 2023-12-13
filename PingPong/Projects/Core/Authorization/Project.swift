//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/07/26.
//

import ProjectDescription
import MyPlugin


let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeFrameWorkModule(
    name: "Authorization",
    bundleId: .appBundleID(name: ".Authorization"),
    product: .staticFramework,
    packages: [
    ],
    setting:  .appBaseSetting,
    dependencies: [
        .domain(implements: .Model),
        .domain(implements: .Service),
        .design(implements: .DesignSystem),
        
        .SPM.CombineMoya,
        .SPM.Moya,
//        .package(product: "FirebaseAuth"),
//        .package(product: "FirebaseFirestore"),
//        .package(product: "FirebaseAuth", type: .plugin),
//        .package(product: "FirebaseFirestore", type: .macro)
        .SPM.FirebaseAuth,
        .SPM.FirebaseFirestore
//        .SPM.GoogleSignIn,
//        .SPM.GoogleSignInSwift

    ],
    sources: ["Sources/**"]
//    resources: ["Resources/**"]
)


