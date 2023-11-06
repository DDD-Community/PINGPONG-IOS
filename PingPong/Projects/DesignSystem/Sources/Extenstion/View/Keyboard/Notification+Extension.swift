//
//  Notification+Extension.swift
//  DesignSystem
//
//  Created by 서원지 on 11/7/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: -  키보드 알림 등록
extension Notification {
    public var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
