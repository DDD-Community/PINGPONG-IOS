//
//  BackEunCustomFont.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//


import Foundation
import SwiftUI



public struct BackEunCustomFont: ViewModifier {
    public var size : CGFloat
    
    public func body(content: Content) -> some View {
        return content.font(.custom("나눔손글씨 배은혜체", fixedSize: size))
    }
}


public extension View {
     public func backEun(size: CGFloat) -> some View {
        return self.modifier(BackEunCustomFont(size: size))
    }
}

public extension UIFont {
    public func backEun(size: CGFloat) -> UIFont?{
        let font = UIFont(name: "나눔손글씨 배은혜체", size: size)
        return font
    }
}

public extension Font {
    public func backEun(size: CGFloat) -> Font{
        let font = Font.custom("나눔손글씨 배은혜체", size: size)
        return font
    }
}
