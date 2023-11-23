//
//  Project.swift
//  Config
//
//  Created by 서원지 on 2023/06/18.
//


import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeFramsWorkModule(
    name: "Search",
    bundleId: .appBundleID(name: "Search"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .design(implements: .DesignSystem),
        .domain(implements: .Service),
        .domain(implements: .Model),
        .feature(implements: .Archive),
        .core(implements: .Common),
        
        .SPM.PopupView,
        .SPM.Inject,
        .SPM.PopupView,
        .SPM.Moya,
        .SPM.CombineMoya
        
        
    ],
    sources: ["Sources/**"]
)
