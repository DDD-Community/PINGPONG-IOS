//
//  ChoiceBreadView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import Model
import SwiftUI

public struct ChoiceBreadView: View {
    @StateObject private var appState: AppState
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject private var bakeViewModel: BakeViewModel = BakeViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var backAction: () -> Void
    
    public init(viewModel: CommonViewViewModel, appState: AppState, backAction: @escaping () -> Void) {
        self._appState = StateObject(wrappedValue: appState)
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
    }
    
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    public var body: some View {
        ZStack {
            VStack {
                topHeaderBackButton()
                    .padding(.top, 20)
                
                selectCatetoryContentView()
                
                Spacer()
                
                confirmButtonView()
                    .padding(.bottom, 30)
                
                
            }
            .frame(height: UIScreen.screenHeight * 0.9)
            .task {
                viewModel.choicedBread = nil
                bakeViewModel.commCodeRequest(commCdTpCd: .source)
            }
            
        }
        .navigationBarHidden(true)
        
        .navigationDestination(isPresented: $appState.isChoicedBread) {
            ChoiceIngredentView(viewModel: viewModel,
                                appState: appState,
                                backAction: backAction,
                                rebakeAction: {
                appState.isChoicedBread = false
            })
        }
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
                        Text("오늘의 빵을 골라주세요.")
                        Spacer()
                    }
                }
                
                .pretendardFont(family: .SemiBold, size: 24)
                .padding(.bottom, 8)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    if let commonData = bakeViewModel.commonCodeModel?.data {
                        let sortedCommCds = commonData.commCds.filter { $0.commCD != "other" && $0.commCD != "proverb" && $0.commCD != "unknown"}
                        ForEach(sortedCommCds, id: \.self) { item in
                            
                            let source: Source = Source(rawValue: item.commCD ?? "") ?? .anime
                            
                            VStack {
                                Circle()
                                    .frame(width: 96, height: 96)
                                    .foregroundColor(self.viewModel.selectSource == source ? .primaryOrange : .primaryOrangeBright)
                                    .overlay(
                                        Image(assetName: source.type.bread.imageName)
                                            .resizable()
                                            .frame(width:56, height: 56)
                                    )
                                Text(source.type.bread.korean)
                                    .pretendardFont(family: .SemiBold, size: 14)
                            }
                            .onTapGesture {
                                self.viewModel.selectSource = source
                                self.viewModel.tmpChoicedBread = source.type.bread
                                print("선택된  source \(self.viewModel.selectSource)")
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 62, trailing: 10))
            
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func confirmButtonView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(viewModel.tmpChoicedBread == nil ? .basicGray3 : .primaryOrange)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("다음")
                        .foregroundColor(viewModel.tmpChoicedBread == nil ? .basicGray5 : .basicWhite)
                        .font(.system(size: 16))
                }
                .onTapGesture {
                    appState.isChoicedBread.toggle()
                    viewModel.choicedBread = viewModel.tmpChoicedBread
                }
                .disabled(viewModel.tmpChoicedBread == nil)
        }
    }

    @ViewBuilder
    private func validateImageView(imageName: String?) -> some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            EmptyView()
        }
    }
}


