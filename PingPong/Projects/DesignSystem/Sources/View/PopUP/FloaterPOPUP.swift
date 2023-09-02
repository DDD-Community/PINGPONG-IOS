//
//  FloaterPOPUP.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

public struct FloaterPOPUP: View {
    var image: ImageAsset
    var floaterTitle: String
    var floaterSubTitle: String
    
    public init(image: ImageAsset, floaterTitle: String, floaterSubTitle: String) {
        self.image = image
        self.floaterTitle = floaterTitle
        self.floaterSubTitle = floaterSubTitle
    }
    
    
    public var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.basicGray3)
                .frame(width: UIScreen.screenWidth - 40, height: 70)
                .overlay {
                    VStack(spacing: .zero) {
                        HStack{
                            Image(asset: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Spacer()
                                .frame(width: 8)
                            
                            Text(floaterTitle)
                                .pretendardFont(family: .SemiBold, size: 16)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            
                        }
                        
                        Spacer()
                            .frame(height: 4)
                        
                        HStack {
                            Text(floaterSubTitle)
                                .pretendardFont(family: .SemiBold, size: 14)
                            Spacer()
                        }
                        
                        
                    }
                    .padding(.horizontal, 20)
                }
            
            
        }
    }
}
