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
        ZStack {
            ScrollView {
                ZStack {
                    Color.gray
                    VStack(alignment: .leading) {
                        FavoriteChoiceTitleView()
                        
                        Text("나는")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 21, trailing: 0))
                            .font(.system(size: 16))
                        
                        ForEach(viewModel.arrayIM.indices) { idx in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(viewModel.isIM[idx] ? Color.pink : .white)
                                .frame(width: UIScreen.screenWidth - 80, height: 40)
                                .overlay {
                                    Text(viewModel.arrayIM[idx])
                                        .font(.system(size: 16))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                }
                                .onTapGesture {
                                    viewModel.toggleIM(at: idx)
                                }
                        }
                        
                        ExceededSelectionView(choiceCount: viewModel.choiceCount)
                            .clipped()
                        
                        Text("내가 좋아하는 건")
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        
                        ForEach(viewModel.arrayFavorite.indices) { idx in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(viewModel.isFavorite[idx] ? Color.red : .white)
                                .frame(width: UIScreen.screenWidth - 80, height: 40)
                                .overlay {
                                    Text(viewModel.arrayFavorite[idx])
                                        .font(.system(size: 16))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                }
                                .onTapGesture {
                                    viewModel.toggleFavorite(at: idx)
                                }
                        }
                        Spacer()
                            .frame(height: 120)
                    }
                    .padding()
                }
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea()
        
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.gray)
                            .frame(width: UIScreen.screenWidth  - 80, height: UIScreen.screenHeight * 0.06)
                            .overlay {
                                Text("확인")
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                            .onTapGesture {
                                // 화면 전환
                                // launchTask += 1
                            }
                    )
            }
        }
        .ignoresSafeArea()
    }
}
