//
//  CharacterColorModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

public struct CharacterColor {
    public let icon: Color
    public let iconBackground: Color
    //    let filter: Color
    public let background: Color
    
    public init(icon: Color, iconBackground: Color, background: Color) {
        self.icon = icon
        self.iconBackground = iconBackground
        self.background = background
    }
}
