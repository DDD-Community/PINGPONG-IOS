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
            
            Image(asset: .splashView)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            
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
