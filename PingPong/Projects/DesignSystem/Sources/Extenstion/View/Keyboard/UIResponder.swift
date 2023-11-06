//
//  UIResponder.swift
//  DesignSystem
//
//  Created by 서원지 on 11/7/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

//MARK: -   키보드 notification 수신
extension UIResponder {
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    private static weak var _currentFirstResponder: UIResponder?

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }

    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
}
