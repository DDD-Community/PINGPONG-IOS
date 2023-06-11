//
//  Project+Settings.swift
//  Config
//
//  Created by 서원지 on 2023/06/11.
//

import Foundation
import ProjectDescription
let buildVersions = "1.0.0"
let buildNumber = "10"


public extension Settings {
    static public func appBaseSetting(name: String) -> Settings {
        return settings(base: ["PRODUCT_NAME": "\(name)",
                               "MARKETING_VERSION": .string(buildVersions),
                               "CURRENT_PROJECT_VERSION": .string(buildNumber),
                               "CODE_SIGN_STYLE": "Automatic",
                               "DEVELOPMENT_TEAM": "N94CS4N6VR", "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File"],
                        configurations: [
                            .debug(name: .debug, settings: ["PRODUCT_NAME": "PingPong"]),
                            .release(name: .release, settings: ["PRODUCT_NAME": "PingPong"])],
                        defaultSettings: .recommended)
    }
}

