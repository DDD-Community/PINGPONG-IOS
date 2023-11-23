//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "HomeApp",
    bundleId: .appBundleID(name: "HomeApp"),
    platform: .iOS,
    product: .app,
    //MARK: - 풀 빌드 할때는 프레임 워크로 변경
//    product: .staticFramework,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
              ],
    
    
    setting: .appMainSetting,
    dependencies: [
        .feature(implements: .Home)
            
    ],
    sources: ["Sources/**", "Resources/**", "Resources/Font/**"],
    resources: ["Resources/**", "Sources/**"],
    infoPlist: .file(path: "Support/HomeInfo.plist"),
    entitlements: .file(path: "Entitlements/HomeApp.entitlements")
//    scheme: [realseScheme, debugScheme]
)





