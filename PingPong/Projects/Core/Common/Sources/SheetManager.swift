//
//  SheetManager.swift
//  Common
//
//  Created by Byeon jinha on 2023/10/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Model

public class SheetManager: ObservableObject {
    public init() { }
    public typealias Config = Action.Info
    @Published public var isPopup: Bool = false
    public enum Action {
        public struct Info {
            public var idx: Int
            
            public init(idx: Int) {
                self.idx = idx
            }
        }
        
        case na
        case present(info: Info)
        case dismiss
    }
    
    @Published public private(set) var action: Action = .na
    
    public func present(with config: Config) {
        guard !action.isPresented else { return }
        if !self.isPopup {
            self.action = .present(info: config)
        }
    }
    
    public func dismiss() {
        self.action = .dismiss
    }
}

extension SheetManager.Action {
    var isPresented: Bool {
        guard case .present(_) = self else { return false }
        return true
    }
}
