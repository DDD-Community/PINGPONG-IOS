//
//  Extenstion+SizeReader.swift
//  Component
//
//  Created by 서원지 on 2023/06/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

public extension View {
    public func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: FlexibleSizePreferenceKey.self, value: geometryProxy.size)
            }
        )
            .onPreferenceChange(FlexibleSizePreferenceKey.self, perform: onChange)
    }
    
    public func readRect(onChange: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: FlexibleFramePreferenceKey.self, value: geometryProxy.frame(in: .global))
            }
        )
            .onPreferenceChange(FlexibleFramePreferenceKey.self, perform: onChange)
    }
    
    public func readRect(name: String, onChange: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: FlexibleFramePreferenceKey.self, value: geometryProxy.frame(in: .named(name)))
            }
        )
            .onPreferenceChange(FlexibleFramePreferenceKey.self, perform: onChange)
    }
}

private struct FlexibleSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

private struct FlexibleFramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}


