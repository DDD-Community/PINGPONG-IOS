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
    packages: [
        
    ],
    setting:  .appBaseSetting,
    dependencies: [
        .domain(implements: .Model),
        .domain(implements: .Service),
        .design(implements: .DesignSystem),
        
        .SPM.CombineMoya,
        .SPM.Moya,
        .SPM.FirebaseAuth,
        .SPM.FirebaseFirestore,
        .SPM.FirebaseDatabase,
//        .SPM.GoogleSignIn,
//        .SPM.GoogleSignInSwift

    ],
    sources: ["Sources/**"]
//    resources: ["Resources/**"]
)


