//
//  ChoiceIngredentView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import Model
import SwiftUI

public struct ChoiceIngredentView: View {
    @StateObject private var appState: AppState
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject private var bakeViewModel: BakeViewModel = BakeViewModel()
    
    var backAction: () -> Void
    var rebakeAction: () -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    public init(viewModel: CommonViewViewModel,appState: AppState, backAction: @escaping () -> Void, rebakeAction: @escaping () -> Void) {
        self._appState = StateObject(wrappedValue: appState)
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
        self.rebakeAction = rebakeAction
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
            
        }
        .task {
            bakeViewModel.commCodeRequest(commCdTpCd: .flavor)
           
        }
        
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $appState.isChoicedIngredent) {
            ChoiceToppingView(viewModel: self.viewModel, appState: appState, backAction: backAction, rebakeAction: rebakeAction)
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
            NavigationLink(destination: ChoiceToppingView(viewModel: self.viewModel, appState: appState, backAction: backAction, rebakeAction: rebakeAction)) {
                Text("건너뛰기")
                    .pretendardFont(family: .Regular, size: 14)
                    .foregroundColor(.basicGray6)
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
                    Text("STEP 2/3")
                        .pretendardFont(family: .SemiBold, size: 18)
                        .foregroundColor(.primaryOrangeText)
                        .padding(.bottom, 8)
                    Spacer()
                }
                VStack {
                    HStack(spacing: 0) {
                        Text("오늘의 재료를 골라주세요.")
                        Spacer()
                    }
                }
                
                .pretendardFont(family: .SemiBold, size: 24)
                .padding(.bottom, 8)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    if let commonData = bakeViewModel.commonCodeModel?.data {
                       
                        ForEach(commonData.commCds, id: \.self) { item in
                            
                            let flavor: Flavor = Flavor(rawValue: item.commCD) ?? .light
                            
                            VStack {
                             
                                
                                Circle()
                                    .frame(width: 96, height: 96)
                                    .foregroundColor(self.viewModel.tmpChoicedIngredent == flavor.type.ingredent ? .primaryOrange : .primaryOrangeBright)
                                    .overlay(
                                        Image(assetName: flavor.type.ingredent.imageName)
                                            .resizable()
                                            .frame(width:56, height: 56)
                                    )
                                
                                Text(flavor.type.ingredent.korean)
                                    .pretendardFont(family: .SemiBold, size: 14)
                            }
                            .onTapGesture {
                                self.viewModel.selectFlavor = flavor
                                self.viewModel.tmpChoicedIngredent = flavor.type.ingredent
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
                .foregroundColor(viewModel.tmpChoicedIngredent == nil ? .basicGray3 : .primaryOrange)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("다음")
                        .foregroundColor(viewModel.tmpChoicedIngredent == nil ? .basicGray5 : .basicWhite)
                        .font(.system(size: 16))
                        .onTapGesture {
                            appState.isChoicedIngredent.toggle()
                            viewModel.choicedIngredent = viewModel.tmpChoicedIngredent
                        }
                }
                .disabled(viewModel.tmpChoicedIngredent == nil)
        }
    }

    @ViewBuilder
    private func validateImageView(imageName: String?) -> some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 16, height: 16)
                //                    .foregroundColor(viewModel.validationColor)
            }
            EmptyView()
            //        }
        }
    }

}

