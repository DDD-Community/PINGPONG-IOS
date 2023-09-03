//
//  BaeEunCustomFont.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//


import Foundation
import SwiftUI



public struct BaeEunCustomFont: ViewModifier {
    public var size : CGFloat
    
    public func body(content: Content) -> some View {
        return content.font(.custom("나눔손글씨 배은혜체", size: size))
    }
}

public extension View {
     public func baeEun(size: CGFloat) -> some View {
        return self.modifier(BaeEunCustomFont(size: size))
    }
}

public extension UIFont {
    public func baeEun(size: CGFloat) -> UIFont?{
        let font = UIFont(name: "나눔손글씨 배은혜체", size: size)
        return font
    }
}

public extension Font {
    public func baeEun(size: CGFloat) -> Font{
        let font = Font.custom("나눔손글씨 배은혜체", size: size)
        return font
    }
}
