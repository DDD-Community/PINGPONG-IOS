//
//  SettingDictionary.swift
//  ProjectDescriptionHelpers
//
//  Created by 서원지 on 2023/05/22.
//

import Foundation

import ProjectDescription


public extension Project {
    static let projectSetting: SettingsDictionary =
    ["OTHER_LDFLAGS": ["-ObjC", "-all_load"], "PRODUCT_NAME": "PingPong","MARKETING_VERSION": .string(buildVersion), "CURRENT_PROJECT_VERSION" : .string(buildNumber), "CODE_SIGN_STYLE": "Automatic",
     "DEVELOPMENT_TEAM": "N94CS4N6VR", "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File" ]
}
