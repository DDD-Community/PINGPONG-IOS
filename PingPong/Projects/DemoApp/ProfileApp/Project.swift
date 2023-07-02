//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/18.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeModule(
    name: "ProfileApp",
    bundleId: .appBundleID(name: "Profile"),
    platform: .iOS,
    product: .app,
    //MARK: - 풀 빌드 할때는 프레임 워크로 변경
//    product: .staticFramework,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
              ],
    
    
    setting: .appMainSetting,
    dependencies: [
        .Projcet.Profile
            
    ],
    sources: ["Sources/**", "Resources/**", "Resources/Font/**"],
    resources: ["Resources/**", "Sources/**"],
    infoPlist: .file(path: "Support/ProfileInfo.plist"),
    entitlements: .relativeToCurrentFile("Entitlements/ProfileApp.entitlements")
//    scheme: [realseScheme, debugScheme]
)

