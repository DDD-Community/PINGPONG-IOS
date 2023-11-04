//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 2023/06/18.
//

import ProjectDescription
import MyPlugin



let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.makeAppModule(
    name: "SearchApp",
    bundleId: .appBundleID(name: "Search"),
    platform: .iOS,
    product: .app,
    //MARK: - 풀 빌드 할때는 프레임 워크로 변경
//    product: .staticFramework,
    packages: [ // packages를 추가하여 Amplify 라이브러리 추가
              ],
    
    
    setting: .appMainSetting,
    dependencies: [
        .feature(implements: .Search)
            
    ],
    sources: ["Sources/**", "Resources/**", "Resources/Font/**"],
    resources: ["Resources/**", "Sources/**"],
    infoPlist: .file(path: "Support/SearchInfo.plist"),
    entitlements: .relativeToCurrentFile("Entitlements/SearchApp.entitlements")
//    scheme: [realseScheme, debugScheme]
)


