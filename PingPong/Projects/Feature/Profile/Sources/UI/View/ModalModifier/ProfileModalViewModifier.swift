//
//  ProfileModalViewModifier.swift
//  Profile
//
//  Created by Byeon jinha on 2023/09/05.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import SwiftUI

struct ProfileModalViewModifier: ViewModifier {
    let shareManager = SharedManger.shared
    
    @StateObject private var viewModel: CommonViewViewModel
    @ObservedObject var sheetManager: SheetManager
    
    var backAction: () -> Void
    var cardChange: () -> Void
    
    // 커스텀 모달 y offset
    let defaultYoffset: CGFloat = 30
    
    public init(viewModel: CommonViewViewModel, sheetManager: SheetManager, cardChange: @escaping() -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._sheetManager = ObservedObject(wrappedValue: sheetManager)
        self.backAction = sheetManager.dismiss
        self.cardChange = cardChange
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if case let .present(config) = sheetManager.action {
                    ProfileModalView(viewModel: self.viewModel,
                              config: config,
                              isPopup: sheetManager.isPopup,
                              defaultYoffset: defaultYoffset)
                    {
                        withAnimation(.spring()) {
//                            viewModel.cards = []
                            sheetManager.dismiss()
                            viewModel.offsetY = defaultYoffset
                            sheetManager.isPopup = false
                        }
                    } cardChange: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            cardChange()
                        }
                    }
                }
            }
    }
}

extension View {
    public func profileModal(with sheetManager: SheetManager, viewModel: CommonViewViewModel, cardChange: @escaping() -> Void) -> some View {
       self.modifier(ProfileModalViewModifier(viewModel: viewModel, sheetManager: sheetManager, cardChange: cardChange))
    }
}
