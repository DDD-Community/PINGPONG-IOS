//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/25.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "OnBoardingApp",
    bundleId: .appBundleID(name: "OnBoardingApp"),
    platform: .iOS,
    product: .app,
    //MARK: - 풀 빌드 할때는 프레임 워크로 변경
//    product: .staticFramework,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
              ],
    
    
    setting: .appMainSetting,
    dependencies: [
        .feature(implements: .OnBoarding)
            
    ],
    sources: ["Sources/**", "Resources/**", "Resources/Font/**"],
    resources: ["Resources/**", "Sources/**"],
    infoPlist: .file(path: "Support/OnBoardingInfo.plist"),
    entitlements: .file(path: "Entitlements/OnBoardingApp.entitlements")
//    scheme: [realseScheme, debugScheme]
)

