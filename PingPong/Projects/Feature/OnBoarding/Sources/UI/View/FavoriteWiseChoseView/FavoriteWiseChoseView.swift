//
//  FavoriteWiseChoseView.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Inject
import DesignSystem

struct FavoriteWiseChoseView: View {
    @ObservedObject private var i0 = Inject.observer
    
    var body: some View {
        VStack {
            ScrollView {
                
                favoriteWiseChooseHeaderTitle()
                
                
                Spacer()
            }
            .bounce(false)
        }
        .navigationBarHidden(true)
        .enableInjection()
    }
    
    @ViewBuilder
    private func favoriteWiseChooseHeaderTitle() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.1)
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text("더 맛있는 명언을 위해")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
            }
                
            HStack(alignment: .center) {
                Text("당신에 대해 알려주세요!")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
            }
            
            Spacer()
                .frame(height: 5)
            
            HStack(alignment: .center) {
                Text("(최대 2개)")
                    .font(.system(size: 18))
                Spacer()
            }
            
            HStack(alignment: .center) {
                Text("나는")
                    .font(.system(size: 18))
                Spacer()
            }
            
            
            
        }
        .padding(.horizontal, 20)
    }
}

struct FavoriteWiseChoseView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteWiseChoseView()
    }
}
