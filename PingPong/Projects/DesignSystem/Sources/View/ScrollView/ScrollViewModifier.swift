//
//  ScrollViewModifier.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/06/25.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

public struct ScrollViewModifier: ViewModifier {
    public init( isBounce: Bool) {
        UIScrollView.appearance().bounces = isBounce
    }
    
    public func body(content: Content) -> some View {
        content
    }

    
}

extension ScrollView {
 
    public func bounce(_ isBounce: Bool) -> some View {
        self.modifier(ScrollViewModifier(isBounce: isBounce))
    }
}

