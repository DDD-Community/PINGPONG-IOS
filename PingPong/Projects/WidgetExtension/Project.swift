//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/07/02.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeWidgetModule(
    name: "WidgetExtension",
    bundleId: .appBundleID(name: ".widget"),
    platform: .iOS,
    product: .appExtension,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
        
              ],
    
    
    setting: .appBaseSetting,
    dependencies: [
//        .SPM.Inject
        
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/AppWidgetInfo.plist"),
    entitlements: .relativeToCurrentFile("Entitlements/Widget.entitlements")
    //    scheme: [realseScheme, debugScheme]
)

//Target(name: "WidgetExtension",
//        platform: .iOS,
//        product: .appExtension,
//        bundleId: bundleID + ".WidgetExtension",
//        deploymentTarget: .iOS(targetVersion: iosVersion, devices: [.iphone]),
//        infoPlist: .file(path: .relativeToRoot("WidgetExtension/Info.plist")),
//        sources: [.glob(.relativeToRoot("WidgetExtension/**"))],
//        resources: [.glob(pattern: .relativeToRoot("WidgetExtension/Resources/**"))],
//        entitlements: .relativeToRoot("Supporting Files/WidgetExtension.entitlements"),
//        dependencies: []
//        )



