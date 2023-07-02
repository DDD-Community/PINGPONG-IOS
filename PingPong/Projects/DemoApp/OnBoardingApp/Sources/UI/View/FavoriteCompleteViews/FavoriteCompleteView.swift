//
//  FavoriteCompleteView.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import SwiftUI

struct FavoriteCompleteView: View {
    let userName: String = "용감한제빵사1834"
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack{
                    HStack{
                        Text(userName)
                            .font(.system(size: 22, weight: .bold))
                        Text("님을 위해")
                            .font(.system(size: 22))
                    }
                    .padding(.top, 20)
                    Text("맞춤 명언을 구워드릴게요!")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 25)
                }
                .frame(height: UIScreen.screenHeight * 0.3)
                
                Circle()
                    .fill(.gray.opacity(0.5))
                    .frame(width: 214, height: 214)
                VStack{
                    Text("명언 취향은 설정에서 언제든지")
                        .font(.system(size: 22))
                        .frame(maxWidth: .infinity)
                    Text("바꿀 수 있어요")
                        .font(.system(size: 22))
                }
                .padding(.top, 50)
                
                RoundedRectangle(cornerRadius: 24)
                    .fill( .gray)
                    .frame(width: UIScreen.screenWidth - 80, height: 40)
                    .overlay {
                        Text("확인")
                            .font(.system(size: 18))
                        
                    }
                    .onTapGesture {
                        //화면 넘기는 로지
                    }
                    .padding(.top, 44)
                Spacer()
            }
            .navigationBarBackButtonHidden()
        }
    }
}
