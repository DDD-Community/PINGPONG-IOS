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
        .remote(url: "https://github.com/exyte/PopupView.git", requirement: .upToNextMinor(from: "2.1.0")),
            .remote(url: "https://github.com/JWAutumn/ACarousel.git", requirement: .upToNextMinor(from: "0.2.0")),
        .remote(url: "https://github.com/krzysztofzablocki/Inject.git", requirement: .upToNextMajor(from: "1.0.5")),
        .remote(url: "https://github.com/kean/NukeUI.git", requirement: .upToNextMajor(from: "0.8.3")),
        
        
        
    ],
    platforms: [.iOS]
)

