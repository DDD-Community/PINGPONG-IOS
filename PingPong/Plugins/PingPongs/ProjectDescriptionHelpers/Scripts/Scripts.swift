//
//  Scripts.swift
//  MyPlugin
//
//  Created by 서원지 on 11/4/23.
//

import Foundation

public enum Scripts {
    public static let FirebaseCrashlytics: String = """
 ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
    "${ROOT_DIR}/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/firebase-ios-sdk/Crashlytics/run"
"""
    public static let GoogleServiceInfo: String =
    """
    if [[ "${CONFIGURATION}" == "Debug" ]]; then
        cp -r "$SRCROOT/ChaeviUS/Project/Resources/Firebase/GoogleService-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
    elif [[ "${CONFIGURATION}" == "Release" ]]; then
        cp -r "$SRCROOT/ChaeviUS/Project/Resources/Firebase/GoogleService-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
    fi
    """
    
    
    public static let widgetPhaseScripts: String = """
    cd "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/"
    if [[ -d "Frameworks" ]]; then
        rm -fr Frameworks
    fi
"""
}
