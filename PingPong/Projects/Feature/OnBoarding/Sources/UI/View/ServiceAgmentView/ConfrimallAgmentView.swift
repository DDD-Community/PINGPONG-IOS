//
//  ConfrimallAgmentView.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/06/25.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Inject
import DesignSystem

struct ConfrimallAgmentView: View {
    @ObservedObject private var i0 = Inject.observer
    var body: some View {
        VStack {
            
            Spacer()
                .frame(height: UIScreen.screenHeight/4)
            
            congratulationMyeongeonBakeryTextView()
            
            loadMyeongeonBakeryImageView()
            
            Spacer()
                .frame(height: UIScreen.screenHeight/5 - 30)
            
            confirmButtonView()
            
            Spacer()
            
        }
        .navigationBarHidden(true)
        .enableInjection()
        
    }
    
    @ViewBuilder
    private func congratulationMyeongeonBakeryTextView() -> some View {
        VStack(alignment: .center) {
            Text("명언제과점의 제빵사가 되신걸")
            Text("축하드립니다!")
        }
        .font(.system(size: 22))
        .bold()
    }
    
    @ViewBuilder
    private func loadMyeongeonBakeryImageView() -> some View {
        VStack {
            Spacer()
                .frame(height: UIScreen.screenWidth/5)
            
            Circle()
                .fill(.gray.opacity(0.4))
                .frame(width: 214, height: 214)
            
        }
    }
    
    
    @ViewBuilder
    private func confirmButtonView() -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray.opacity(0.6))
                .frame(width: UIScreen.screenWidth - 100, height: 50)
                .overlay {
                    Text("확인")
                        .font(.system(size: 22))
                }
        }
    }
      
}

struct ConfrimallAgmentView_Previews: PreviewProvider {
    static var previews: some View {
        ConfrimallAgmentView()
    }
}
