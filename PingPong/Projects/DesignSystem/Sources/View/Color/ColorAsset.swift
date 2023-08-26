//
//  ColorAsset.swift
//  Component
//
//  Created by 서원지 on 2023/06/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI


public enum Colors: String {
    case  primaryOrange = "primaryOrange"
    case Navy
    case Gray
    case Gray2
    case Gray3
    case LanchColor
}


public extension Color {
    static let primaryOrange = pingColor(.primaryOrange)
    static let navy = pingColor(.Navy)
    static let grays = pingColor(.Gray)
    static let gray2 = pingColor(.Gray2)
    static let gray3 = pingColor(.Gray3)
    static let lanch = pingColor(.LanchColor)
    
}




public extension Color {
    
    static func pingColor(_ color: Colors) -> Color {
        guard let uiColor = UIColor(named: color.rawValue, in: Bundle.module, compatibleWith: nil) else {
            fatalError("No color named '\(color.rawValue)' found in asset catalog for module \(Bundle.module)")
        }
        return Color(uiColor)
    }
}



