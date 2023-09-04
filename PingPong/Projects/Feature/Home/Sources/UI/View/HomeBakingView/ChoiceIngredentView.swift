//
//  ChoiceIngredentView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import Model

public struct ChoiceIngredentView: View {
    @StateObject private var viewModel: HomeViewViewModel
    
    var backAction: () -> Void
    public init(viewModel: HomeViewViewModel, backAction: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
    }
    
    let IngredentArray: [String] = ["chocolate", "cheese", "jalapeno", "cream", "corn"]
    let IngredentDictionary = [
        "chocolate": "초콜릿",
        "cheese": "치즈",
        "jalapeno": "할라피뇨",
        "cream": "생크림",
        "corn": "옥수수"
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
        .navigationDestination(isPresented: $viewModel.isChoicedIngredent) {
            ChoiceToppingView(viewModel: self.viewModel, backAction: backAction)
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
            Text("건너뛰기")
                .pretendardFont(family: .Regular, size: 14)
                .foregroundColor(.basicGray6)
                .onTapGesture {
                    //                    viewModel.isSelectedCategory.toggle()
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
                    ForEach(IngredentArray, id: \.self) { item in
                        VStack {
                            Circle()
                                .frame(width: 96, height: 96)
                                .foregroundColor(self.viewModel.choicedIngredent ==  Ingredent(rawValue: item)! ? .primaryOrange : .primaryOrangeBright)
                                .overlay(
                                    Image(assetName: item)
                                )
                            
                            Text(IngredentDictionary[item]!)
                                .pretendardFont(family: .SemiBold, size: 14)
                        }
                        .onTapGesture {
                            self.viewModel.choicedIngredent = Ingredent(rawValue: item)!
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
                .foregroundColor(viewModel.choicedIngredent == nil ? .basicGray3 : .primaryOrange)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("다음")
                        .foregroundColor(viewModel.choicedIngredent == nil ? .basicGray5 : .basicWhite)
                        .font(.system(size: 16))
                        .onTapGesture {
                            viewModel.isChoicedIngredent.toggle()
                        }
                }
                .disabled(viewModel.choicedIngredent == nil)
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

