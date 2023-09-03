//
//  DnfCustomFont.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI



public struct DnfCustomFont: ViewModifier {
    public var size : CGFloat
    
    public func body(content: Content) -> some View {
        return content.font(.custom("DNFBitBitTTF", fixedSize: size))
    }
}


public extension View {
     public func dNFBitBit(size: CGFloat) -> some View {
        return self.modifier(DnfCustomFont(size: size))
    }
}

public extension UIFont {
    public func dNFBitBit(size: CGFloat) -> UIFont?{
        let font = UIFont(name: "DNFBitBitTTF", size: size)
        return font
    }
}

public extension Font {
    public func dNFBitBit(size: CGFloat) -> Font{
        let font = Font.custom("DNFBitBitTTF", size: size)
        return font
    }
}
