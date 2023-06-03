//
//  Extension+UIScreen.swift
//  Component
//
//  Created by 서원지 on 2023/06/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

public extension UIScreen {
    public static let screenWidth = UIScreen.main.bounds.size.width
    public static let screenHeight = UIScreen.main.bounds.size.height
    public static let screenSize = UIScreen.main.bounds.size
    public static let qrcodeButtonWidth = screenWidth - (screenWidth * 0.1)
    
}

