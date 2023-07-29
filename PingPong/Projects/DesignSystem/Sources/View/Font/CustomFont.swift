//
//  CustomFont.swift
//  Component
//
//  Created by 서원지 on 2023/06/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import UIKit
import SwiftUI

public enum PretendardFontFamily: CustomStringConvertible {
    case Black, Bold, ExtraBold, ExtraLight, Light, Medium, Regular, SemiBold, Thin
    
    public var description: String {
        switch self {
        case .Black:
            return "Black"
        case .Bold:
            return "Bold"
        case .ExtraBold:
            return "ExtraBold"
        case .ExtraLight:
            return "ExtraLight"
        case .Light:
            return "Light"
        case .Medium:
            return "Medium"
        case .Regular:
            return "Regular"
        case .SemiBold:
            return "SemiBold"
        case .Thin:
            return "Thin"
        }
    }
}


public struct PretendardFont: ViewModifier {
    public var family: PretendardFontFamily
    public var size: CGFloat
    public var fontName: FontName
    
    public func body(content: Content) -> some View {
        return content.font(.custom("\(fontName)-\(family)", fixedSize: size))
    }
}

public extension View {
     public func pretendardFont(family: PretendardFontFamily, size: CGFloat) -> some View {
         return self.modifier(PretendardFont(family: family, size: size, fontName: .pretendard))
    }
}

public extension UIFont {
    public static func pretendardFontFamily(family: PretendardFontFamily, size: CGFloat) -> Font{
        let font = Font.custom("Pretendard-\(family)", size: size)
        return font
    }
}

public extension Font {
    public static func pretendardFontFamily(family: PretendardFontFamily, size: CGFloat) -> Font{
        let font = Font.custom("Pretendard-\(family)", size: size)
        return font
    }
}


public struct NanumBaeEunHyeCeFont: ViewModifier {
    public var size: CGFloat
    public var fontName: FontName
    public func body(content: Content) -> some View {
        return content.font(.custom(fontName.rawValue , fixedSize: size))
    }
}

public extension View {
    public func nanumBaeEunHyeCeFont(size: CGFloat, fonName: FontName) -> some View {
        return self.modifier(NanumBaeEunHyeCeFont(size: size, fontName: fonName))
    }
}

public extension UIFont {
    public static func NanumBaeEunHyeCeFont(family: NanumBaeEunHyeCeFont, size: CGFloat) -> Font{
        let font = Font.custom("나눔손글씨 배은혜체", size: size)
        return font
    }
}

public extension Font {
    public static func NanumBaeEunHyeCeFont(family: NanumBaeEunHyeCeFont, size: CGFloat) -> Font{
        let font = Font.custom("나눔손글씨 배은혜체", size: size)
        return font
    }
}


public enum FontName: String, CustomStringConvertible {
    case baeEun
    case dnf
    case pretendard
    
    public var description: String {
        switch self {
        case .baeEun:
            return "나눔손글씨 배은혜체"
        case .dnf:
            return "DNFBitBitTTF"
        case .pretendard:
            return "Pretendard"
        }
    }
}
