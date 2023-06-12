//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/11.
//


import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeModule(
    name: "PingPong",
    platform: .iOS,
    product: .app,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
        
              ],
    
    
    setting: .appMainSetting,
    dependencies: [
        .SPM.Moya,
        .SPM.CombineMoya,
        .SPM.Kingfisher,
        .SPM.PopupView,
        .Projcet.Network,
        .Projcet.Component,
//        .Projcet.HomeApp

        
    ],
    sources: ["Sources/**", "Resources/**", "Resources/Font/**"],
    resources: ["Resources/**", "Sources/**"],
    infoPlist: .file(path: "Support/Info.plist"),
    entitlements: .relativeToCurrentFile("Entitlements/PingPong.entitlements")
//    scheme: [realseScheme, debugScheme]
)




