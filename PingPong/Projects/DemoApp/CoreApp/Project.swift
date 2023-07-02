//
//  CoreApp.swift
//  Manifests
//
//  Created by 서원지 on 2023/07/02.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeModule(
    name: "CoreApp",
    bundleId: .appBundleID(name: "CoreApp"),
    platform: .iOS,
    product: .app,
    //MARK: - 풀 빌드 할때는 프레임 워크로 변경
//    product: .staticFramework,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
              ],
    
    
    setting: .appMainSetting,
    dependencies: [
        .Projcet.Core
            
    ],
    sources: ["Sources/**", "Resources/**"],
    resources: ["Resources/**", "Sources/**"],
    infoPlist: .file(path: "Support/CoreAppInfo.plist"),
    entitlements: .relativeToCurrentFile("Entitlements/CoreApp.entitlements")
//    scheme: [realseScheme, debugScheme]
)

