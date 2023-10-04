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
    name: "Search",
    bundleId: .appBundleID(name: "Search"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.PopupView,
        .SPM.Inject,
        .SPM.PopupView,
        .Projcet.DesignSystem,
        .Projcet.Service,
        .Projcet.Model,
        .SPM.Moya,
        .SPM.CombineMoya,
        
    ],
    sources: ["Sources/**"]
)
