//
//  Project.swift
//  Config
//
//  Created by 서원지 on 2023/06/18.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeFrameWorkModule(
    name: "Home",
    bundleId: .appBundleID(name: "Home"),
    product: .staticFramework,
    setting:  .appBaseSetting,
    dependencies: [
        .design(implements: .DesignSystem),
        .domain(implements: .Service),
        .domain(implements: .Model),
        .core(implements: .Authorization),
        .core(implements: .Common),
        .feature(implements: .Bake),
        .feature(implements: .Search),
        .feature(implements: .Profile),
        
        .SPM.PopupView,
        .SPM.Inject,
        .SPM.PopupView,
        .SPM.Moya,
        .SPM.CombineMoya,
        .SPM.Collections
        
            
        
            
    ],
    sources: ["Sources/**"]
)
