//
//  Extension+Color.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/07/22.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

public extension Color {
    static let authorFontColor = pingPongColor(.authorFontColor)
    static let buttonOrange = pingPongColor(.buttonOrange)
    static let contentsFontColor = pingPongColor(.contentsFontColor)
    static let nutty = pingPongColor(.nutty)
    static let nuttyBackground = pingPongColor(.nuttyBackground)
    static let nuttyContents = pingPongColor(.nuttyContents)
    static let plain = pingPongColor(.plain)
    static let plainBackground = pingPongColor(.plainBackground)
    static let plainContents = pingPongColor(.plainContents)
    static let salty = pingPongColor(.salty)
    static let saltyBackground = pingPongColor(.saltyBackground)
    static let saltyContents = pingPongColor(.saltyContents)
    static let spicy = pingPongColor(.spicy)
    static let spicyBackground = pingPongColor(.spicyBackground)
    static let spicyContents = pingPongColor(.spicyContents)
    static let statusBarColor = pingPongColor(.statusBarColor)
    static let sweety = pingPongColor(.sweety)
    static let sweetyBackground = pingPongColor(.sweetyBackground)
    static let sweetyContents = pingPongColor(.sweetyContents)
    static let tabbarColor = pingPongColor(.tabbarColor)
    static let tabbarSelectedColor = pingPongColor(.tabbarSelectedColor)
}




public extension Color {
    
    static func pingPongColor(_ color: Colors) -> Color {
        guard let uiColor = UIColor(named: color.rawValue, in: Bundle.module, compatibleWith: nil) else {
            fatalError("No color named '\(color.rawValue)' found in asset catalog for module \(Bundle.module)")
        }
        return Color(uiColor)
    }
}

