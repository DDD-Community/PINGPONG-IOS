//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 10/4/23.
//

import ProjectDescription
import MyPlugin


let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeFramsWorkModule(
    name: "Common",
    bundleId: .appBundleID(name: ".Common"),
    product: .staticFramework,
    packages: [

    ],
    setting:  .appBaseSetting,
    dependencies: [
        .domain(implements: .Service),
        .domain(implements: .Model),
        .design(implements: .DesignSystem),
        .SPM.CombineMoya,
        .SPM.Moya,
    ],
    sources: ["Sources/**"]
//    resources: ["Resources/**"]
)
