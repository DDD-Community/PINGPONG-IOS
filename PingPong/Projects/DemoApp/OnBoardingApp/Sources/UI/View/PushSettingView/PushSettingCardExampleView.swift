//
//  PushSettingCardExampleView.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct PushSettingCardExampleView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(Color.gray)
            .frame(width:333, height: 122)
            .overlay(
                HStack{
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 57)
                    VStack(alignment: .leading){
                        Text("오늘의 명언입니다")
                            .font(.system(size: 16, weight: .bold))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        Text("내일 죽는다해도")
                            .font(.system(size: 16))
                        Text("오늘 최선을 다하자")
                            .font(.system(size: 16))
                    }
                    .frame(width: UIScreen.screenWidth * 0.4)
                }
            )
            .padding(.top, 50)
    }
}
