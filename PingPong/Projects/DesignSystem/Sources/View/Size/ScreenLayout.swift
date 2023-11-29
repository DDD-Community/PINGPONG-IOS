//
//  ScreenLayout.swift
//  DesignSystem
//
//  Created by 서원지 on 11/27/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import UIKit

public enum ScreenLayout {
    public static let LayoutMargin: CGFloat = 20
    public static let LayoutMarginAll: CGFloat = 40
    public static let ContentsWidth: CGFloat = (UIScreen.screenWidth - LayoutMarginAll)

    public static let modalTopTransparentSize: CGFloat = 64.0

    public static let TopLeftRightRadius = 20.0
    public static let TopLeftRightRadius30 = 30.0

    public static let BottomSheetTopBarViewHeight: CGFloat = 80
    public static let BottomButtonHeight: CGFloat = 55
    public static let BottomSafeAreaInset = UIDevice.hasNotch ? UIApplication.safeAreaInsets.bottom : 30

    public static let TitleBarHeight: CGFloat = 44

}



