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
            
            VStack {
                Spacer()
                
                Image(asset: .pingpongLogo)
                    .padding(.bottom, 16)
                Text("명언제과점")
                    .font(.custom("PretendardVariable-SemiBold", size: 24))
                    .foregroundColor(.white)
                    .padding(.bottom, 162)
                Text("있으면 좀 더 행복한\n500g 더 나은 삶을 위한 서비스")
                    .font(.custom("PretendardVariable-SemiBold", size: 18))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    
                Spacer()
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    showLanchView.toggle()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLanchView: .constant(true))
    }
}
