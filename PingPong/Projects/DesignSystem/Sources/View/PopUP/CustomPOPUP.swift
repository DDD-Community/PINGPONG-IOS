//
//  CustomPOPUP.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

public struct CustomPOPUP: View {
    var image: ImageAsset
    var title: String
    var subTitle: String
    var useGif: Bool
    
    public init(image: ImageAsset, title: String, subTitle: String, useGif: Bool) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.useGif = useGif
    }
    
    public var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.basicWhite)
                .frame(width: UIScreen.screenWidth - 40, height: 280)
                .overlay {
                    VStack {
                        popupImage()
                        
                        popupTitle()
                    }
                }
            
        }
    }
    
    @ViewBuilder
    private func popupImage() -> some View {
        VStack {
            if useGif {
                AnimatedImage(name: "swipe.gif", isAnimating: .constant(true))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 141, height: 141)
            } else {
                Image(asset: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 69, height: 69)
            }
        }
    }
    
    @ViewBuilder
    private func popupTitle() -> some View {
        Spacer()
            .frame(height: 8)
        
        VStack(spacing: 10) {
            Text(title)
                .pretendardFont(family: .SemiBold, size: 14)
                .foregroundColor(.black)
            
            Text(subTitle)
                .pretendardFont(family: .SemiBold, size: 14)
        }
    }
}


