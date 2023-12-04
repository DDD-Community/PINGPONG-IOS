//
//  SelectCategoryView.swift
//  OnBoarding
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import Model
import Common

public struct SelectCategoryView: View {
    @StateObject private var viewModel: OnBoardingViewModel
    @StateObject private var commonViewViewModel: CommonViewViewModel
    
    public init(viewModel: OnBoardingViewModel, commonViewViewModel: CommonViewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._commonViewViewModel = StateObject(wrappedValue: commonViewViewModel)
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    public var body: some View {
        ZStack {
            VStack {
                topHeaderBackButton()
                    .padding(.top, 20)
               Spacer()
            }
            VStack {
                selectCatetoryContentView()
                
                Spacer()
                confirmButtonView()
                    .padding(.bottom, 30)
            }
            .padding(.top, 40)
            .frame(height: UIScreen.screenHeight * 0.9)
            
        }
        .task {
            viewModel.onBoardingSearchUserRequest()
        }
        
        
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 18)
                .foregroundColor(.gray)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            Text("건너뛰기")
                .pretendardFont(family: .Regular, size: 14)
                .foregroundColor(.basicGray6)
                .onTapGesture {
                    commonViewViewModel.viewPath.append(ViewState.isSelectedCategory)
                }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func selectCatetoryContentView() -> some View {
        Spacer()
            .frame(height: 25)
        
        Group {
            VStack{
                HStack(spacing: 0) {
                    Text("STEP 1/3")
                        .pretendardFont(family: .SemiBold, size: 18)
                        .foregroundColor(.primaryOrangeText)
                        .padding(.bottom, 8)
                    Spacer()
                }
                VStack {
                    HStack(spacing: 0) {
                        Text("어떤 카테고리의 명언을")
                        Spacer()
                    }
                    HStack(spacing: 0) {
                        Text("좋아하세요?")
                        Spacer()
                    }
                }
                
                .pretendardFont(family: .SemiBold, size: 24)
                .padding(.bottom, 8)
                
                HStack(spacing: 0) {
                    Text("원하는 카테고리를 ")
                        .pretendardFont(family: .SemiBold, size: 16)
                    Text("최대 2개")
                        .pretendardFont(family: .Bold, size: 16)
                    Text("를 선택해보세요.")
                        .pretendardFont(family: .SemiBold, size: 16)
                    Spacer()
                }
                .foregroundColor(.basicGray6)
                .padding(.bottom, 8)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    let searchUserCategory = viewModel.onBoardingSearchUserModel?.data?.filter{$0.commCDTpID == 2}
                    if let firstSearchUserCategory = searchUserCategory?.first {
                        let sortedCommCds = firstSearchUserCategory.commCds ?? []
                        
                        ForEach(sortedCommCds, id: \.self) { item in
                            VStack {
                                let favoirte = Source(rawValue: item.commCD ?? "")
                                
                                if viewModel.selectedFavorite.contains(Source(rawValue: (favoirte ?? .anime).rawValue) ?? .anime){
                                    Circle()
                                        .frame(width: 96, height: 96)
                                        .foregroundColor(.basicGray3)
                                        .overlay(
                                            Image(assetName: item.commCD ?? "")
                                        )
                                } else {
                                    Circle()
                                        .frame(width: 96, height: 96)
                                        .foregroundColor(.primaryOrangeOpacity40)
                                        .overlay(
                                            Image(assetName: "\(item.commCD)Gray")
                                        )
                                }

                                Text(item.commNm ?? "")
                                    .pretendardFont(family: .SemiBold, size: 14)
                            }
                            .onTapGesture {
                                
                                let source = Source(rawValue: item.commCD ?? "")
                                if let favorite = source {
                                    self.viewModel.appendAndPopFavorite(favorite: favorite)

                                }
                                self.viewModel.selectedFavoriteCategory = item.commCD ?? ""
                                
                                
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 62, trailing: 10))
                
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private func confirmButtonView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(viewModel.selectedFavorite.count > 0 ? .primaryOrange : .basicGray3)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("다음")
                        .foregroundColor(viewModel.selectedFavorite.count > 0 ? .basicWhite : .basicGray5)
                        .font(.system(size: 16))
                        .onTapGesture {
                            commonViewViewModel.viewPath.append(ViewState.isSelectedCategory)
                        }
                }
                .disabled(viewModel.selectedFavorite.count < 1)
        }
    }
    
    @ViewBuilder
    private func validateImageView(imageName: String?) -> some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(viewModel.validationColor)
            }
            EmptyView()
        }
    }
}
