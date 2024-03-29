//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/11.
//


import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "PingPong",
    bundleId: .mainBundleID(),
    platform: .iOS,
    product: .app,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
        
    ],
    setting: .appMainSetting,
    dependencies: [
        
//        .package(product: "FirebaseMessaging"),
        
        .SPM.FirebaseMessaging,
        .feature(implements: .OnBoarding)
//        .SPM.GoogleSignIn,
//        .sdk(name: "GTMAppAuth+", type: .library),
//        .sdk(name: "WidgetKit", type: .framework),
        

        
    ],
    sources: ["Sources/**", "Resources/**", "Resources/FontAsset/**"],
    resources: ["Resources/**", "Sources/**"],
    infoPlist: .file(path: "Support/Info.plist"),
    entitlements: .file(path: "Entitlements/PingPong.entitlements")
//    scheme: [realseScheme, debugScheme]
)





