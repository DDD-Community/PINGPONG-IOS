//
//  Project+Settings.swift
//  ProjectDescriptionHelpers
//
//  Created by 서원지 on 2023/05/22.
//

import Foundation
import ProjectDescription
let version = "1.0.0"
let buildNumber = "10"


extension Settings {
    static func appBaseSetting() -> Settings {
        return settings(base: ["PRODUCT_NAME": "PingPong",
                               "MARKETING_VERSION": .string(version),
                               "CURRENT_PROJECT_VERSION": .string(buildNumber),
                               "CODE_SIGN_STYLE": "Automatic",
                               "DEVELOPMENT_TEAM": "N94CS4N6VR", "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File"],
                        configurations: [
                            .debug(name: .debug, settings: ["PRODUCT_NAME": "PingPong"]),
                            .release(name: .release, settings: ["PRODUCT_NAME": "PingPong"])],
                        defaultSettings: .recommended)
    }
}


