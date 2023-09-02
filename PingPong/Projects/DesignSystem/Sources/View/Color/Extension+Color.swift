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
    static let primaryOrange = Color(hex: "FF9960")
    
}




public extension Color {
    
    init(hex: String) {
             let scanner = Scanner(string: hex)
             _ = scanner.scanString("#")
             
             var rgb: UInt64 = 0
             scanner.scanHexInt64(&rgb)
             
             let r = Double((rgb >> 16) & 0xFF) / 255.0
             let g = Double((rgb >>  8) & 0xFF) / 255.0
             let b = Double((rgb >>  0) & 0xFF) / 255.0
             self.init(red: r, green: g, blue: b)
           }

    
    static func pingPongColor(_ color: Colors) -> Color {
        guard let uiColor = UIColor(named: color.rawValue, in: Bundle.module, compatibleWith: nil) else {
            fatalError("No color named '\(color.rawValue)' found in asset catalog for module \(Bundle.module)")
        }
        return Color(uiColor)
    }
}

