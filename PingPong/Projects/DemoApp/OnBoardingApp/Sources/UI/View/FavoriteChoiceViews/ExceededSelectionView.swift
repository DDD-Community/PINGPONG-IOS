//
//  ExceededSelectionView.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct ExceededSelectionView: View {
    var choiceCount: Int
    var body: some View {
        ZStack{
            if choiceCount < 2{
                Spacer()
                    .frame(width: 20, height: 20)
            } else {
                HStack{
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 20, height: 20)
                    Text("2개를 이미 선택하셨어요!")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                }
                
            }
        }
        .frame( height: 20)
    }
}
