//
//  FavoriteChoiceView.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import DesignSystem

struct FavoriteChoiceView: View {
    @ObservedObject var viewModel: FavoriteChoiceViewModel
    init(viewModel: FavoriteChoiceViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    ZStack {
                        Color.gray
                        VStack(alignment: .leading) {
                            FavoriteChoiceTitleView()
                            
                            Text("나는")
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 21, trailing: 0))
                                .font(.system(size: 16))
                            FavoriteChoiceListView(favoriteArray: viewModel.arrayIM,
                                                   isArray: viewModel.isIM,
                                                   toggleOn: viewModel.toggleIM(at:))
                            
                            ExceededSelectionView(choiceCount: viewModel.choiceCount)
                                .clipped()
                            
                            Text("내가 좋아하는 건")
                                .padding(.horizontal, 20)
                            
                            FavoriteChoiceListView(favoriteArray: viewModel.arrayFavorite,
                                                   isArray: viewModel.isFavorite,
                                                   toggleOn: viewModel.toggleFavorite(at:))
                            
                            Spacer()
                                .frame(height: 120)
                        }
                        .padding()
                    }
                }
                .bounce(false)
                .ignoresSafeArea()
                .scrollIndicators(.hidden)
            }
            
            ZStack {
                VStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.gray)
                                .frame(width: UIScreen.screenWidth - 80, height: 40)
                                .overlay {
                                    Text("확인")
                                        .font(.system(size: 16))
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                }
                                .onTapGesture {
                                    viewModel.pushSettingView.toggle()
                                }
                        )
                }
                .frame(height: 120)
            }
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $viewModel.pushSettingView) {
                PushSettingView()
            }
        }
        .ignoresSafeArea()
    }
}
