//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeModule(
    name: "Network",
    bundleId: .appBundleID(name: "Network"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.Moya,
        .SPM.CombineMoya,
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"]
)
