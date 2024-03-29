//
//  Dependencies.swift
//  Config
//
//  Created by 서원지 on 2023/06/11.
//

import ProjectDescription

let swiftPackageManger = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMinor(from: "15.0.0")),
    .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMinor(from: "7.6.0")),
    .remote(url: "https://github.com/exyte/PopupView.git", requirement: .upToNextMinor(from: "2.1.0")),
    .remote(url: "https://github.com/krzysztofzablocki/Inject.git", requirement: .upToNextMajor(from: "1.0.5")),
    .remote(url: "https://github.com/kean/NukeUI.git", requirement: .upToNextMajor(from: "0.8.3")),
    .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "10.0.0")),
    .remote(url: "https://github.com/apple/swift-collections.git", requirement: .branch("main")),
//        .remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .upToNextMajor(from: "6.2.4")),
    .remote(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", requirement: .upToNextMajor(from: "2.0.0")),
    .remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .exact("6.2.4"))
])

let dependencie = Dependencies(
    swiftPackageManager: swiftPackageManger,
    platforms: [.iOS]
)

