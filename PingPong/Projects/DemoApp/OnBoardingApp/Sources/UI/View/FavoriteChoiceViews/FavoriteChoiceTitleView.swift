//
//  FavoriteChoiceTitleView.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct FavoriteChoiceTitleView: View {
    var body: some View {
            Text("더 맛있는 명언을 위해")
                .padding(EdgeInsets(top: 101, leading: 0, bottom: 8, trailing: 0))
                .font(.system(size: 22, weight: .bold))
            
            Text("당신에 대해 알려주세요!")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                .font(.system(size: 22, weight: .bold))

            Text("(최대 2개)")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 29, trailing: 0))
                .font(.system(size: 16))
    }
}
