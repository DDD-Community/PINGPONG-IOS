//
//  Extension+UIColor.swift
//  Component
//
//  Created by 서원지 on 2023/06/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
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

public extension UIColor {
 
    static func pingPongColor (_ color: Colors) -> UIColor? {
        return UIColor(named: color.rawValue,  in: Bundle.module, compatibleWith:  nil)
    }
}

