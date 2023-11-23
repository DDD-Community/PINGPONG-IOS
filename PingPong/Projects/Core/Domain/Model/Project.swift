//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/07/26.
//


import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeFramsWorkModule(
    name: "Model",
    bundleId: .appBundleID(name: ".Model"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        
    ],
    sources: ["Sources/**"]
//    resources: ["Resources/**"]
)

