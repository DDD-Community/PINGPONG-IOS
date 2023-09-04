//
//  FamousSayingBakeView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct FamousSayingBakeView: View {
    var body: some View {
        VStack {
            Image(assetName: "famousSayingBakeImage")
                .resizable()
                .frame(width: 240, height: 240)
            Text("명언을 굽는 중입니다...")
                .pretendardFont(family: .SemiBold, size: 20)
                .foregroundColor(.basicGray8)
        }
        .navigationBarHidden(true)
    }
}

struct FamousSayingBakeView_Previews: PreviewProvider {
    static var previews: some View {
        FamousSayingBakeView()
    }
}
