//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeModule(
    name: "HomeApp",
    platform: .iOS,
    product: .app,
    //MARK: - 풀 빌드 할때는 프레임 워크로 변경
//    product: .staticFramework,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
              ],
    
    
    setting: .appMainSetting,
    dependencies: [
        .SPM.Moya,
        .SPM.CombineMoya,
        .SPM.Kingfisher,
        .SPM.PopupView,
        .SPM.ACarousel,
        .SPM.Inject,
        .Projcet.Home,
        .Projcet.Authentication,
        .Projcet.Network
            
            
            
            
            

        
        
    ],
    sources: ["Sources/**", "Resources/**", "Resources/Font/**"],
    resources: ["Resources/**", "Sources/**"],
    infoPlist: .file(path: "Support/HomeInfo.plist"),
    entitlements: .relativeToCurrentFile("Entitlements/HomeApp.entitlements")
//    scheme: [realseScheme, debugScheme]
)





