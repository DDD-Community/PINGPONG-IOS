//
//  ScreenSize.swift
//  DesignSystem
//
//  Created by 서원지 on 11/27/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

public class ScreenSize {
    public static let shared = ScreenSize()
    
    public let bounds = UIScreen.main.bounds
    
    public let tabItemWidth: CGFloat = UIScreen.main.bounds.width / 4
    
    public var tabBarHeight: CGFloat {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom == 0 ? 49 : 84
    }
    
    public var tabBarFrameHeight : CGFloat {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom == 0 ? -20 :  20
    }
    
    public var tabBarOffset: CGFloat {
        if UIDevice.hasNotch == true {
            let bottomSafeAreaInset = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0
            let tabBarHeight: CGFloat = bottomSafeAreaInset > 0 ? 5 : 5
            return UIScreen.screenHeight / 40 - tabBarHeight
        } else {
            return UIScreen.screenHeight / 40 - 15
        }
    }



    public var chargingHeight: Int {
        if UIDevice.hasNotch {
            return Int(UIScreen.screenHeight/3 + 20)
        } else {
            return Int(UIScreen.screenHeight/3 + 10)
        }
    }
    

    public var widthtmp: Int {
        return Int(UIScreen.main.bounds.width - (bounds.width * 0.1))
    }
    
    public var heighttmp: Int {
        return Int(bounds.height / 4) - 50
    }
    
    public var pY: Int {
        return Int(bounds.height / 3) + 50
    }
    
    public var pX: Int {
        return Int((Int(bounds.width)/2) - (widthtmp/2))
    }
}
