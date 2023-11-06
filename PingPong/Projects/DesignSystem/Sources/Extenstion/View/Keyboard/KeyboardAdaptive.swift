//
//  KeyboardHandler.swift
//  DesignSystem
//
//  Created by 서원지 on 11/7/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Combine

//MARK: -  키보드가 뷰를 가릴때  사용

public struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat = 0
    @State private var isKeyboardVisible = false

    public func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, bottomPadding) // Always use bottomPadding
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    let keyboardTop = geometry.frame(in: .global).height + keyboardHeight
                    let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                    let offset = focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom
                    let offset2 = focusedTextInputBottom - geometry.safeAreaInsets.bottom * 0.4


                    // Only adjust the padding if the keyboard is actually visible
                    if keyboardHeight > 0 {
                        if offset > 0 {
                            self.bottomPadding = offset2
                        } else {
                            self.bottomPadding = 0
                            self.bottomPadding = offset
                        }
                        self.isKeyboardVisible = true
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    withAnimation {
                        bottomPadding = .zero//TODO: -
                    }
                }
                .animation(.easeOut(duration: 0.16))
                .onDisappear {
                    // When the view disappears, reset the bottom padding and keyboard visibility
                    self.bottomPadding = 0
                    self.isKeyboardVisible = false
                }
        }
    }
}


extension View {
    public func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
