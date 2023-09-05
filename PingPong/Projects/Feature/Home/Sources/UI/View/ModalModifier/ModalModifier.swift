//
//  ModalModifier.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/05.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct ModalViewModifier: ViewModifier {
    @ObservedObject var sheetManager: SheetManager
    @State var offsetY: CGFloat = 0
    @Binding var searchViewButtonInfoArray: [SearchViewButtonInfo]
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if case let .present(config) = sheetManager.action {
                    ModalView(config: config, isPopup: sheetManager.isPopup, searchViewButtonInfoArray: $searchViewButtonInfoArray, offsetY: $offsetY) {
                        withAnimation(.spring()) {
                            sheetManager.dismiss()
                            offsetY = 0
                            sheetManager.isPopup = false
                        }
                    }
                }
            }
    }
}

extension View {
    func modal(with sheetManager: SheetManager, searchViewButtonInfoArray: Binding<[SearchViewButtonInfo]>) -> some View {
        self.modifier(ModalViewModifier(sheetManager: sheetManager, searchViewButtonInfoArray: searchViewButtonInfoArray))
    }
}
