//
//  ModalModifier.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/05.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import SwiftUI

struct ModalViewModifier: ViewModifier {
    let shareManager = SharedManger.shared
    
    @StateObject private var viewModel: CommonViewViewModel
    @ObservedObject var sheetManager: SheetManager
    
    var backAction: () -> Void
    
    // 커스텀 모달 y offset
    let defaultYoffset: CGFloat = 30
    
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
                              isPopup: sheetManager.isPopup,
                              defaultYoffset: defaultYoffset)
                    {
                        withAnimation(.spring()) {
                            sheetManager.dismiss()
                            viewModel.offsetY = defaultYoffset
                            sheetManager.isPopup = false
                        }
                    }
                }
            }
    }
}

extension View {
   public func modal(with sheetManager: SheetManager, viewModel: CommonViewViewModel) -> some View {
        self.modifier(ModalViewModifier(viewModel: viewModel, sheetManager: sheetManager))
    }
}
