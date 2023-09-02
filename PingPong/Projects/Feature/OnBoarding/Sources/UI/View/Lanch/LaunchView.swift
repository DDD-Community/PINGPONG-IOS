//
//  LanchView.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/06/25.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Inject
import DesignSystem

public struct LaunchView: View {
    @Binding var showLanchView: Bool
    
    
    
    public init(showLanchView: Binding<Bool>) {
        self._showLanchView = showLanchView
    }
    
    public var body: some View {
        ZStack {
            Color.primaryOrange
                .edgesIgnoringSafeArea(.all)
            
            Image(asset: .splash)
                .resizable()
                .scaledToFill()
                .offset(y: -20)
            
            VStack(spacing: 8) {
                Spacer()
                    .frame(height: UIScreen.screenHeight/2 + (UIScreen.screenWidth*0.5))
                
                Text("있으면 좀 더 행복한")
                    .foregroundColor(.basicWhite)
                    .gmarketSans(family: .Medium, size: 22)
                
                
                Text("500g 더 나은 삶을 위한 서비스")
                    .foregroundColor(.basicWhite)
                    .gmarketSans(family: .Medium, size: 22)
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                showLanchView.toggle()
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLanchView: .constant(true))
    }
}
