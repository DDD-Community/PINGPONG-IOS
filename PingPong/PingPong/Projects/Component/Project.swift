//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 서원지 on 2023/06/02.
//

import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.makeModule(
    name: "Component",
    product: .staticFramework,
    setting:  .settings(base: ["PRODUCT_NAME": "chaevi",
                               "MARKETING_VERSION": "1.0",
                               "CURRENT_PROJECT_VERSION": "1",
                               "CODE_SIGN_STYLE": "Automatic",
                               "DEVELOPMENT_TEAM": "N94CS4N6VR", "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File"] ,configurations: [
                                .debug(name: .debug),
                                .release(name: .release)
                               ],defaultSettings: .recommended),
    dependencies: [
        .SPM.Moya,
        .SPM.CombineMoya,
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"]
)


