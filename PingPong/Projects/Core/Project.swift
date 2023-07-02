//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/07/02.
//


import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeModule(
    name: "Core",
    bundleId: .appBundleID(name: "Core"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.Inject,
        .Projcet.OnBoarding,
        .Projcet.Home,
        .Projcet.Profile,
        .Projcet.Authentication,
        .Projcet.Search
        
    ],
    sources: ["Sources/**"]
//    resources: ["Resources/**"]
)
