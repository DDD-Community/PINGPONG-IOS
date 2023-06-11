//
//  Dependencies.swift
//  Config
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription

let dependencie = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMinor(from: "15.0.0")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMinor(from: "7.6.0")),
        .remote(url: "https://github.com/exyte/PopupView.git", requirement: .upToNextMinor(from: "2.1.0"))
        
        
    ],
    platforms: [.iOS]
)

