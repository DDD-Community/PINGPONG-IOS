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
    static let basicWhite = Color(hex: "#FFFFFF")
    static let basicBlack = Color(hex: "#000000")
    static let basicBlackDimmed = Color(hex: "#333332").opacity(0.7)
    static let basicGray1BG = Color(hex: "#FFFDFA")
    static let basicGray2 = Color(hex: "#F9F9F9")
    static let basicGray3 = Color(hex: "#F2F2F1")
    static let basicGray4 = Color(hex: "#CCCAC8")
    static let basicGray5 = Color(hex: "#BEBCB9")
    static let basicGray6 = Color(hex: "#999896")
    static let basicGray7 = Color(hex: "#666564")
    static let basicGray8 = Color(hex: "#333332")
    static let basicGray9 = Color(hex: "#232320")

    // 상태 색상
    static let statusWarning = Color(hex: "#FF717D")
    static let statusSuccess = Color(hex: "#3CC882")

    // 주요 색상
    static let primaryOrange = Color(hex: "#FF9960")
    static let primaryOrangeText = Color(hex: "#FF772B")
    static let primaryOrangeOpacity30 = Color(hex: "#FF9960").opacity(0.3)
    static let primaryOrangeOpacity40 = Color(hex: "#FF9960").opacity(0.4)
    static let primaryOrangeLight = Color(hex: "#FDC9AD")
    static let primaryOrangeMedium = Color(hex: "#C59F83")
    static let primaryOrangeDark = Color(hex: "#522F16")
    static let primaryOrangeBright = Color(hex: "#FCF7F2")

    // 카드 배경 색상
    static let sweetBG = Color(hex: "#F7E9E9")
    static let sweetIconBG = Color(hex: "#EFDEDE")
    static let sweetIconText = Color(hex: "#D89191")
    static let sweetFilter = Color(hex: "#EFD3D3")

    static let saltyBG = Color(hex: "#E6F5FA")
    static let saltyIconBG = Color(hex: "#D6EAF1")
    static let saltyIconText = Color(hex: "#61A0B6")

    static let hotBG = Color(hex: "#F1E8E3")
    static let hotIconBG = Color(hex: "#EFDED2")
    static let hotIconText = Color(hex: "#BB8C72")

    static let nuttyBG = Color(hex: "#F7F3E2")
    static let nuttyIconBG = Color(hex: "#EBE5CC")
    static let nuttyIconText = Color(hex: "#AE9769")
    static let nuttyFilter = Color(hex: "#CEC0A5")

    static let mildBG = Color(hex: "#EAF3E8")
    static let mildIconBG = Color(hex: "#DAE7D7")
    static let mildIconText = Color(hex: "#869E81")

    // 카드 텍스트 색상
    static let cardTextMain = Color(hex: "#6B511F")

    // 추가 아이콘 색상
    static let motivateIcon = Color(hex: "#FFC3A1")
    static let consolationIcon = Color(hex: "#D1F1ED")
    static let wisdomIcon = Color(hex: "#FFF3B6")
    
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

