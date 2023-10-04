//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 10/4/23.
//

import ProjectDescription
import MyPlugin


let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "Common",
    bundleId: .appBundleID(name: ".Common"),
    product: .staticFramework,
    packages: [

    ],
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.CombineMoya,
        .SPM.Moya,
        .Projcet.Model,
        .Projcet.Service
    ],
    sources: ["Sources/**"]
//    resources: ["Resources/**"]
)
