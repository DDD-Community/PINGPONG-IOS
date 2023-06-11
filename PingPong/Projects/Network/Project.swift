//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.makeModule(
    name: "Network",
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .SPM.Moya,
        .SPM.CombineMoya,
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"]
)
