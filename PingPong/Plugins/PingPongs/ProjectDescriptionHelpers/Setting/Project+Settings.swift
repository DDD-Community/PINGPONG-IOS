//
//  Project+Settings.swift
//  Config
//
//  Created by 서원지 on 2023/06/11.
//

import Foundation
import ProjectDescription


extension Settings {
    public static let appMainSetting: Settings = .settings(
        base: [ "PRODUCT_NAME": "PingPong",
                "CFBundleDisplayName" : "PingPong",
                "MARKETING_VERSION": .string(.appVersion()),
                "AS_AUTHENTICATION_SERVICES_ENABLED": "YES",
                "PUSH_NOTIFICATIONS_ENABLED":"YES",
                "ENABLE_BACKGROUND_MODES" : "YES",
                "BACKGROUND_MODES" : "remote-notification",
                "ASSOCIATED_DOMAINS": "applinks:PingPong.page.link",
                "CURRENT_PROJECT_VERSION": .string(.appBuildVersion()),
                "CODE_SIGN_IDENTITY": "iPhone Developer",
                "CODE_SIGN_STYLE": "Automatic",
                "DEVELOPMENT_TEAM": "N94CS4N6VR",
                "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File",
                "DEVELOPMENT_ASSET_PATH" : "\"Resources/Preview Content\""]
        ,configurations: [
            .debug(name: .debug, settings: [
                "PRODUCT_NAME" : "PingPong",
                "DISPLAY_NAME" : "PingPong",
                "OTHER_LDFLAGS": [
                    "-Xlinker", "-interposable", "-all_load", // Set the strip style to non-global symbols
                ],
                "STRIP_STYLE": [
                    "non-global"
                ],
            ]),
            .debug(name: "Dev", settings: [
                "PRODUCT_NAME" : "PingPong-Dev",
                "DISPLAY_NAME" : "PingPong",
                "OTHER_LDFLAGS": [
                    "-Xlinker", "-interposable", "-all_load", // Set the strip style to non-global symbols
                ],
                "STRIP_STYLE": [
                    "non-global"
                ],
                
            ]),
            .release(name: .release, settings: [
                "DEVELOPMENT_ASSET_PATHS": "\"Resources/Preview Content\"",
                "PRODUCT_NAME" :"PingPongs" ,
                "DISPLAY_NAME" : "PingPong" ,
                "CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER": "NO",
                "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES": "YES",
                "OTHER_SWIFT_FLAGS": "-Xcc -Wno-error=non-modular-include-in-framework-module",
                "OTHER_LDFLAGS": [
                     "-all_load",
                ],
                "STRIP_STYLE": [
                    "non-global"
                ],
                
            ])], defaultSettings: .recommended)
                                                                           
                                                                           
   public static let appBaseSetting: Settings = .settings(
        base: ["PRODUCT_NAME": "PingPong",
                "MARKETING_VERSION": .string(.appVersion()),
                "CURRENT_PROJECT_VERSION": .string(.appBuildVersion()),
                "CODE_SIGN_STYLE": "Automatic",
                "DEVELOPMENT_TEAM": "N94CS4N6VR", "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File"],configurations: [
                .debug(name: .debug, settings: [
                    "PRODUCT_NAME": "PingPong",
                    "OTHER_LDFLAGS": [
                        "-Xlinker", "-interposable","-all_load", "-ObjC"],
                    "CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER": "NO",
                    "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES": "YES",
                           "OTHER_SWIFT_FLAGS": "-Xcc -Wno-error=non-modular-include-in-framework-module"
                ]),
                .release(name: .release, settings: [
                    "PRODUCT_NAME": "PingPong",
                    "OTHER_LDFLAGS": ["-Xlinker", "-interposable", "-all_load", "-ObjC"],
                    "CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER": "NO",
                    "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES": "YES",
                           "OTHER_SWIFT_FLAGS": "-Xcc -Wno-error=non-modular-include-in-framework-module"
                ])], defaultSettings: .recommended)
                                                                           
    public static let appWidgetSetting: Settings = .settings(
        base: [ "PRODUCT_NAME": "PingPong",
                "CFBundleDisplayName" : "PingPong",
                "MARKETING_VERSION": .string(.appVersion()),
                "CURRENT_PROJECT_VERSION": .string(.appBuildVersion()),
                "CODE_SIGN_IDENTITY": "iPhone Developer",
                "CODE_SIGN_STYLE": "Automatic",
                "DEVELOPMENT_TEAM": "N94CS4N6VR",
                "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File",
                "DEVELOPMENT_ASSET_PATH" : "\"Resources/Preview Content\""] ,configurations: [
                    .debug(name: .debug, settings: ["PRODUCT_NAME" : "PingPong","DISPLAY_NAME" : "PingPong",  "OTHER_LDFLAGS": ["-Xlinker", "-interposable",  "-all_load", "-ObjC"]]),
                    .debug(name: "Dev", settings: ["PRODUCT_NAME" : "PingPong-Dev","DISPLAY_NAME" : "PingPong",  "OTHER_LDFLAGS": ["-Xlinker", "-interposable", "-all_load"]]),
                    .release(name: .release, settings: ["DEVELOPMENT_ASSET_PATHS": "\"Resources/Preview Content\"","PRODUCT_NAME" :"PingPongs" , "DISPLAY_NAME" : "PingPong" ,  "OTHER_LDFLAGS": ["-Xlinker", "-interposable", "-all_load", "-ObjC"]])],
        defaultSettings: .recommended)}
                                                                           
                                                                           
