//
//  FavoriteWiseChoseView.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct FavoriteWiseChoseView: View {
    public init() { }
    
//    @StateObject private var viewModel: OnBoardingViewModel
//       
//       public init(viewModel: OnBoardingViewModel) {
//           self._viewModel = StateObject(wrappedValue: viewModel)
//       }
    @StateObject private var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    public var body: some View {
        NavigationStack {
            VStack {
                favoriteWiseChooseHeaderTitle()
                Spacer()
                Image(assetName: "selectFavoriteImage")
                
                Spacer()
                startButtonView()
                    .padding(.bottom, 30)
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $viewModel.isStartChoiceFavoritedView) {
                SelectCategoryView(viewModel: self.viewModel)
            }
        }
    }
    
    @ViewBuilder
    private func favoriteWiseChooseHeaderTitle() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.1)
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text("더 맛있는 명언을 위해")
                Spacer()
            }
                
            HStack(alignment: .center, spacing: 0) {
                Text("\(self.viewModel.nickname)")
                    .foregroundStyle(Color.primaryOrange)
                Text("님에 대해 알려주세요.")
                    
                Spacer()
            }
        }
        .pretendardFont(family: .SemiBold, size: 24)
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func startButtonView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.primaryOrange)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("시작하기")
                        .foregroundColor(.basicWhite)
                        .font(.system(size: 16))
                        .onTapGesture {
                            viewModel.isStartChoiceFavoritedView.toggle()
                        }
                }
        }
    }
}
