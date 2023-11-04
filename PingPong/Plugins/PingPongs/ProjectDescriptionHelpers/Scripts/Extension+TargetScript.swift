//
//  Extension+TargetScript.swift
//  MyPlugin
//
//  Created by 서원지 on 11/4/23.
//

import ProjectDescription

public extension TargetScript {
    static let FirebaseCrashlyticsString = TargetScript.post(
        script: Scripts.FirebaseCrashlytics,
        name: "FirebaseCrashlytics",
        inputPaths: [
            "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}",
            "$(SRCROOT)/$(BUILT_PRODUCTS_DIR)/$(INFOPLIST_PATH)",
            "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/Resources/Firebase/GoogleService-Info.plist -p ios ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
            
        ],
        basedOnDependencyAnalysis: true, // 또는 true, 필요에 따라 변경
        runForInstallBuildsOnly: true    // 또는 true, 필요에 따라 변경
    )
    
    static let GoogleServiceInfoString = TargetScript.pre(
        script: Scripts.GoogleServiceInfo,
        name: "GoogleServiceInfo",
        inputPaths: [],
        basedOnDependencyAnalysis: false,
        runForInstallBuildsOnly: true
    )
    
    static let widgetRunScripts = TargetScript.pre(
        script: Scripts.widgetPhaseScripts,
        name: "widgetPhaseScripts",
        inputPaths: [],
        basedOnDependencyAnalysis: true,
        runForInstallBuildsOnly: true
    )
}
