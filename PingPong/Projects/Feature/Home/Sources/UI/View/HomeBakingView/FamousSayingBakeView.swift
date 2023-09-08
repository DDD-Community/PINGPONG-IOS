//
//  FamousSayingBakeView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SDWebImageSwiftUI
import SwiftUI

struct FamousSayingBakeView: View {
    
    @StateObject private var viewModel: HomeViewViewModel
    var backAction: () -> Void
    var rebakeAction: () -> Void
    
    public init(viewModel: HomeViewViewModel, backAction: @escaping () -> Void, rebakeAction: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
        self.rebakeAction = rebakeAction
    }
    
    var body: some View {
        VStack {
            
            
            AnimatedImage(name: "bakingGIF.gif", isAnimating: .constant(true))
                .resizable()
                .frame(width: 240, height: 240)
            
            Text("명언을 굽는 중입니다...")
                .pretendardFont(family: .SemiBold, size: 20)
                .foregroundColor(.basicGray8)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $viewModel.isCompleteBake) {
            FamousSayingBakeCardView(viewModel: self.viewModel, backAction: backAction, rebakeAction: rebakeAction)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.viewModel.isCompleteBake.toggle()
            }
        }
    }
}
