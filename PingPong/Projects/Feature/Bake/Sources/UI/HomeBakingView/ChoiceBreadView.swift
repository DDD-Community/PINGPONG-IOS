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
    var backAction: () -> Void
    
    public init(viewModel: CommonViewViewModel, appState: AppState, backAction: @escaping () -> Void) {
        self._appState = StateObject(wrappedValue: appState)
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
    }
        
    let breadArray: [String] = ["carouselgreatmanImage", "carouselceleImage", "carouseldramaImage", "carouselanimeImage", "carouselbookImage"]
    let breadDictionary = [
        "carouselgreatmanImage": "식빵",
        "carouselceleImage": "크로아상",
        "carouseldramaImage": "팬케익",
        "carouselanimeImage": "쿠키",
        "carouselbookImage": "치아바타"
    ]
    
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
                    ForEach(breadArray, id: \.self) { item in
                        VStack {
                            Circle()
                                .frame(width: 96, height: 96)
                                .foregroundColor(self.viewModel.tmpChoicedBread ==  Bread(rawValue: item)! ? .primaryOrange : .primaryOrangeBright)
                                .overlay(
                                    Image(assetName: item)
                                        .resizable()
                                        .frame(width:56, height: 56)
                                )
                            
                            Text(breadDictionary[item]!)
                                .pretendardFont(family: .SemiBold, size: 14)
                        }
                        .onTapGesture {
                            self.viewModel.tmpChoicedBread = Bread(rawValue: item)!
                            print("타입 \(item)")
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
                        .onTapGesture {
                            appState.isChoicedBread.toggle()
                            viewModel.choicedBread = viewModel.tmpChoicedBread
                        }
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


