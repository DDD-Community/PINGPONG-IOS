//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.makeModule(
    name: "Component",
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"]
)

