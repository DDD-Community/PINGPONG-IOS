//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/18.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeFrameWorkModule(
    name: "Auth",
    bundleId: .appBundleID(name: "Auth"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .design(implements: .DesignSystem),
        .core(implements: .Authorization),
        
        .SPM.Kingfisher,
        .SPM.PopupView,
        .SPM.Inject,
        .SPM.PopupView,
       
        
        
            
    ],
    sources: ["Sources/**"]
)

