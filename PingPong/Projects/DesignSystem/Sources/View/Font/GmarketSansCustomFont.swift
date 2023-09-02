//
//  GmarketSansCustomFont.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

public enum GmarketSansCustomFontFamily: String {
    case Bold, Light, Medium
}

public struct GmarketSansCustomFont: ViewModifier {
    public var family: GmarketSansCustomFontFamily
    public var size : CGFloat
    
    public func body(content: Content) -> some View {
        return content.font(.custom("GmarketSansTTF\(family)", fixedSize: size))
    }
}


public extension View {
     public func gmarketSans(family: GmarketSansCustomFontFamily, size: CGFloat) -> some View {
        return self.modifier(GmarketSansCustomFont(family: family, size: size))
    }
}

public extension UIFont {
    public func gmarketSans(family: GmarketSansCustomFontFamily, size: CGFloat) -> UIFont?{
        let font = UIFont(name: "GmarketSansTTF\(family)", size: size)
        return font
    }
}

public extension Font {
    public func gmarketSans(family: GmarketSansCustomFontFamily, size: CGFloat) -> Font{
        let font = Font.custom("GmarketSansTTF\(family)", size: size)
        return font
    }
}

