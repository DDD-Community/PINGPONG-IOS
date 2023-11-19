//
//  WithDrawPOPUP.swift
//  DesignSystem
//
//  Created by 서원지 on 11/18/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

public struct WithDrawPOPUP: View {
    var image: ImageAsset
    var title: String
    var subTitle: String
    var noImage: Bool
    
    var confirmAction: () -> Void
    var cancelAction: () -> Void
    
    public init(
        image: ImageAsset,
        title: String,
        subTitle: String,
        confirmAction: @escaping () -> Void,
        cancelAction: @escaping () -> Void,
        noImage: Bool
    ) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.confirmAction = confirmAction
        self.cancelAction = cancelAction
        self.noImage = noImage
    }
    
    public var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.basicWhite)
                .frame(width: UIScreen.screenWidth - 40, height: 200)
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
            Spacer()
                .frame(height: 16)
            
            if !noImage {
                Image(asset: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
            }
        }
    }
    
    @ViewBuilder
    private func popupTitle() -> some View {
        Spacer()
            .frame(height: 8)
        
        VStack(spacing: 8) {
            Text(title)
                .pretendardFont(family: .SemiBold, size: 18)
                .foregroundColor(.black)
            
            Text(subTitle)
                .pretendardFont(family: .SemiBold, size: 14)
                .foregroundColor(.basicGray6)
        }
        
        Spacer()
            .frame(height: 19)
    }
    
    @ViewBuilder
    private func popupButton() -> some View {
        
        
        if noImage {
            VStack(spacing: .zero) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.basicGray4)
                    .frame(width: UIScreen.screenWidth/3, height: 48)
                    .overlay {
                        VStack(alignment: .center) {
                            Text("닫기")
                                .pretendardFont(family: .SemiBold, size: 16)
                                .foregroundColor(.basicWhite)
                        }
                    }
                    .onTapGesture {
                        cancelAction()
                    }
                
                Spacer()
                    .frame(height: 16)
            }
        } else {
            VStack(spacing: .zero) {
                HStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.basicGray4)
                        .frame(width: UIScreen.screenWidth/3, height: 48)
                        .overlay {
                            VStack(alignment: .center) {
                                Text("취소")
                                    .pretendardFont(family: .SemiBold, size: 16)
                                    .foregroundColor(.basicWhite)
                            }
                        }
                        .onTapGesture {
                            cancelAction()
                        }
                    
                    Spacer()
                        .frame(width: 12)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.basicBlack)
                        .frame(width: UIScreen.screenWidth/3, height: 48)
                        .overlay {
                            VStack(alignment: .center) {
                                Text("탈퇴하기")
                                    .pretendardFont(family: .SemiBold, size: 16)
                                    .foregroundColor(.basicWhite)
                            }
                        }
                        .onTapGesture {
                            confirmAction()
                        }
                    
                    
                }
                
                Spacer()
                    .frame(height: 16)
            }
        }
    }
}


