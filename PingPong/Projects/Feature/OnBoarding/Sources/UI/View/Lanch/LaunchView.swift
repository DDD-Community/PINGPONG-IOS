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
            Color.white
            
            VStack {
                Spacer()
                
                Circle()
                    .fill(.gray.opacity(0.5))
                    .frame(width: 214, height: 214)
                
                Spacer()
                    .frame(height: UIScreen.screenWidth/6)
                
                
                Text("명언제과점에 오신걸 환영합니다")
                    .font(.system(size: 22))
                    .bold()
                
                
                
                Spacer()
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    showLanchView.toggle()
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLanchView: .constant(true))
    }
}
