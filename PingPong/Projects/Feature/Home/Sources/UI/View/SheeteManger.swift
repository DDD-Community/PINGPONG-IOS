//
//  SheeteManger.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

public class SheetManager: ObservableObject {
    public init() { }
    typealias Config = Action.Info
    var isPopup: Bool = false
    enum Action {
        struct Info {
            var idx: Int
        }
        case na
        case present(info: Info)
        case dismiss
    }
    
    @Published private(set) var action: Action = .na
    
    func present(with config: Config) {
        guard !action.isPresented else { return }
        if !self.isPopup {
            self.action = .present(info: config)
        }
    }
    
    func dismiss() {
        self.action = .dismiss
    }
}

extension SheetManager.Action {
    var isPresented: Bool {
        guard case .present(_) = self else { return false }
        return true
    }
}
