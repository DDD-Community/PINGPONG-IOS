//
//  LoadingView.swift
//  DesignSystem
//
//  Created by 서원지 on 11/16/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

public struct LoadingView: View {
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.basicGray1BG
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                Spacer()
                
                AnimatedImage(name: "bakeLoading.gif", isAnimating: .constant(true))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                
                Spacer()
                    .frame(height: UIScreen.screenHeight*0.03)
                
                Text("내게 꼭 맞는 명언을\n불러오고 있어요")
                    .pretendardFont(family: .SemiBold, size: 24)
                    .foregroundColor(Color.basicGray9)
                
                Spacer()
                    .frame(height: 17)
                
                Text("잠시만 기다려주세요!")
                    .pretendardFont(family: .Medium, size: 16)
                    .foregroundColor(Color.basicGray6)
                
                
                Spacer()

                
            }
            
        }
    }
}

#Preview {
    LoadingView()
}
