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
    
    var confirmAction: () -> Void
    
    public init(image: ImageAsset, title: String, subTitle: String, useGif: Bool, confirmAction: @escaping () -> Void) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.useGif = useGif
        self.confirmAction = confirmAction
    }
    
    public var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.basicWhite)
                .frame(width: UIScreen.screenWidth - 40, height: useGif ? 320: 300)
                .overlay {
                    VStack {
                        popupImage()
                        
                        popupTitle()
                        
                        
                        popupButton()
                    }
                }
            
        }
    }
    
    @ViewBuilder
    private func popupImage() -> some View {
        VStack {
            if useGif {
                Spacer()
                    .frame(height: 16)
                
                AnimatedImage(name: "swipe.gif", isAnimating: .constant(true))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 141, height: 141)
            } else {
                Spacer()
                    .frame(height: 16)
                
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
            if useGif {
                Text(title)
                    .pretendardFont(family: .Bold, size: 18)
                    .foregroundColor(.black)
            } else {
                Text(title)
                    .pretendardFont(family: .SemiBold, size: 14)
                    .foregroundColor(.black)
                
                Text(subTitle)
                    .pretendardFont(family: .SemiBold, size: 14)
                    .foregroundColor(.basicGray6)
            }
        }
    }
    
    @ViewBuilder
    private func popupButton() -> some View {
        Spacer()
            .frame(height: 28)
        
        VStack {
            if useGif {
                HStack {
//                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.primaryOrange)
                        .frame(width: 140, height: 38)
                        .overlay {
                            Text("네 알겠습니다")
                                .pretendardFont(family: .SemiBold, size: 18)
                        }
                        .onTapGesture {
                            confirmAction()
                        }
                    
                    
//                    Spacer()
                }
            } else {
                HStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.primaryOrange)
                        .frame(width: UIScreen.screenWidth/3, height: 48)
                        .overlay {
                            Text("확인")
                                .pretendardFont(family: .SemiBold, size: 16)
                        }
                        .onTapGesture {
                            confirmAction()
                        }
                    
                }
            }
        }
    }
}


