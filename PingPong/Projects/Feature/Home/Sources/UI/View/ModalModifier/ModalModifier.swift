//
//  ModalModifier.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/05.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Authorization
import Common
import DesignSystem
import SwiftUI

struct ModalViewModifier: ViewModifier {
    let shareManager = SharedManger.shared
    
    @StateObject private var viewModel: CommonViewViewModel
    @ObservedObject var sheetManager: SheetManager
    
    var backAction: () -> Void
    
    public init(viewModel: CommonViewViewModel, sheetManager: SheetManager) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._sheetManager = ObservedObject(wrappedValue: sheetManager)
        self.backAction = sheetManager.dismiss
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if case let .present(config) = sheetManager.action {
                    ModalView(viewModel: self.viewModel,
                              config: config,
                              isPopup: sheetManager.isPopup)
                    {
                        withAnimation(.spring()) {
                            sheetManager.dismiss()
                            viewModel.offsetY = 0
                            sheetManager.isPopup = false
                        }
                    }
                }
            }
    }
}

extension View {
    func modal(with sheetManager: SheetManager, viewModel: CommonViewViewModel) -> some View {
        self.modifier(ModalViewModifier(viewModel: viewModel, sheetManager: sheetManager))
    }
}
