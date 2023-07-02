//
//  BakeBreadView.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import SwiftUI

struct BakeBreadView: View {
    @State var favoriteCompleteView: Bool = false

    public var body: some View {
        NavigationStack{
            ZStack {
                Color.white
                VStack {
                    VStack{
                        Spacer()
                        Text("제빵사님을 위한 명언을 굽고 있어요")
                            .font(.system(size: 22))
                            .padding(.bottom, 50)
                    }
                    .frame(height: UIScreen.screenHeight * 0.3)
                    
                    Circle()
                        .fill(.gray.opacity(0.5))
                        .frame(width: 214, height: 214)
                    Spacer()
                    
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        favoriteCompleteView.toggle()
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $favoriteCompleteView) {
                FavoriteCompleteView()
            }
        }
    }
}
