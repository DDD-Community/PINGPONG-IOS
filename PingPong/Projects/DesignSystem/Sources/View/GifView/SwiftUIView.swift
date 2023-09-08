//
//  GifView.swift
//  DesignSystem
//
//  Created by Byeon jinha on 2023/09/08.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SDWebImageSwiftUI
import SwiftUI

public struct GifView: View {
    public init() { }
    
    public var body: some View {
        AnimatedImage(name: "swipe.gif", isAnimating: .constant(true))
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
}
