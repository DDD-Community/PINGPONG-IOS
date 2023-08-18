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
    static let inputBox = pingPongColor(.inputBox)
    static let whiteGray50 = pingPongColor(.whiteGray50)
    static let primaryDark = pingPongColor(.primaryDark)
    static let primaryDefault = pingPongColor(.primaryDefault)
    static let primaryPoint = pingPongColor(.primaryPoint)
    static let primaryStrong = pingPongColor(.primaryStrong)
    static let primarySub = pingPongColor(.primarySub)
    static let secondaryDefault = pingPongColor(.secondaryDefault)
    static let secondaryPoint = pingPongColor(.secondaryPoint)
    static let secondaryStrong = pingPongColor(.secondaryStrong)
    static let secondarySub = pingPongColor(.secondarySub)
    static let major = pingPongColor(.major)
    static let nonMajor = pingPongColor(.nonMajor)
    static let green = pingPongColor(.primaryDark)
    static let orange = pingPongColor(.orange)
    static let purple = pingPongColor(.primaryDark)
    static let purplePoint = pingPongColor(.purple)
    static let recruit = pingPongColor(.recruit)
    static let recruitLight = pingPongColor(.recruitLight)
    static let recruitPoint = pingPongColor(.recruitPoint)
    static let background = pingPongColor(.background)
    static let bluegrey = pingPongColor(.bluegrey)
    static let grey0 = pingPongColor(.grey0)
    static let grey1 = pingPongColor(.grey1)
    static let grey2 = pingPongColor(.grey2)
    static let grey3 = pingPongColor(.grey3)
    static let grey4 = pingPongColor(.grey4)
    static let greys = pingPongColor(.greys)
    static let lightgrey = pingPongColor(.lightgrey)
    
}




public extension Color {
    
    static func pingPongColor(_ color: Colors) -> Color {
        guard let uiColor = UIColor(named: color.rawValue, in: Bundle.module, compatibleWith: nil) else {
            fatalError("No color named '\(color.rawValue)' found in asset catalog for module \(Bundle.module)")
        }
        return Color(uiColor)
    }
}

