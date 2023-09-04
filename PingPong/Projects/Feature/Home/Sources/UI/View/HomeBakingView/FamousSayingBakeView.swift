//
//  FamousSayingBakeView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct FamousSayingBakeView: View {
    
    @StateObject private var viewModel: HomeViewViewModel
    
    public init(viewModel: HomeViewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
        .navigationDestination(isPresented: $viewModel.isCompleteBake) {
            FamousSayingBakeCardView(viewModel: self.viewModel)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                self.viewModel.isCompleteBake.toggle()
            }
        }
    }
}
