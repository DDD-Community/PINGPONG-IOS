//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 서원지 on 2023/05/22.
//

import ProjectDescription
import ProjectDescriptionHelpers


let version: String = "1.0.0"
let buildNumber: String = "10"



let project = Project.makeModule(
    name: "PingPong",
    platform: .iOS,
    product: .app,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
        
              ],
    
    
    setting: .settings(base: ["PRODUCT_NAME": "PingPong",
                              "CFBundleDisplayName" : "PingPong",
                              "MARKETING_VERSION": .string(version),
                              "AS_AUTHENTICATION_SERVICES_ENABLED": "YES",
                              "PUSH_NOTIFICATIONS_ENABLED":"YES",
                              "ENABLE_BACKGROUND_MODES" : "YES",
                              "BACKGROUND_MODES" : "remote-notification",
                              "ASSOCIATED_DOMAINS": "applinks:PingPong.page.link",
                              "CURRENT_PROJECT_VERSION": .string(buildNumber),
                              "CODE_SIGN_IDENTITY": "iPhone Developer",
                              "CODE_SIGN_STYLE": "Automatic",
                              "DEVELOPMENT_TEAM": "N94CS4N6VR", "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File", "DEVELOPMENT_ASSET_PATH" : "\"Resources/Preview Content\""] ,configurations: [
                                .debug(name: .debug, settings: ["PRODUCT_NAME" : "PingPong","DISPLAY_NAME" : "PingPong"]),
                                .debug(name: "Dev", settings: ["PRODUCT_NAME" : "PingPong 필수앱-Dev","DISPLAY_NAME" : "PingPong"]),
                                .release(name: .release, settings: ["DEVELOPMENT_ASSET_PATHS": "\"Resources/Preview Content\"","PRODUCT_NAME" :"PingPong" , "DISPLAY_NAME" : "PingPong" ])
                              ], defaultSettings: .recommended),
    dependencies: [
        .SPM.Moya,
        .SPM.CombineMoya,
        .SPM.Kingfisher,
        .SPM.PopupView,
        .Projcet.Network,
        .Projcet.Component
        
    ],
    sources: ["Sources/**", "Resources/**", "Resources/Font/**"],
    resources: ["Resources/**", "Sources/**"],
    infoPlist: .file(path: "Support/Info.plist"),
    entitlements: .relativeToCurrentFile("Entitlements/PingPong.entitlements")
//    scheme: [realseScheme, debugScheme]
)




