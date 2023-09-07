//
//  FamousSayingBakeCardView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct FamousSayingBakeCardView: View {
    
    @StateObject private var viewModel: HomeViewViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject var sheetManager: SheetManager = SheetManager()
    
    var backAction: () -> Void
    var rebakeAction: () -> Void
    
    public init(viewModel: HomeViewViewModel, backAction: @escaping () -> Void, rebakeAction: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
        self.rebakeAction = rebakeAction
    }
    
    var body: some View {
        ZStack {
            VStack {
                topHeaderBackButton()
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
                Spacer()
            }
            VStack {
                let post = viewModel.homePosts[0]
                let imageNameAndText = self.viewModel.generateImageNameAndText(hashtags: post.hashtags)
                let size = UIScreen.main.bounds.size
                let colorSet = searchCharacterColor(flavor: post.hashtags.flavor)
                
                let shareView =
                VStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(colorSet.background)
                    
                        .frame(width: size.width  - 40, height: size.height * 0.6)
                        .overlay(
                            ZStack {
                                VStack {
                                    HStack {
                                        ZStack {
                                            Image(assetName: imageNameAndText.2)
                                                .resizable()
                                                .frame(width: 335, height: 236)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                            ZStack {
                                                if let choicedBread = viewModel.choicedBread  {
                                                    Image(assetName: "\(choicedBread.rawValue)")
                                                        .resizable()
                                                        .frame(width: 120, height: 120)
                                                }
                                                if let choicedIngredent = viewModel.choicedIngredent  {
                                                    Image(assetName: "\(choicedIngredent.rawValue)")
                                                        .resizable()
                                                        .frame(width: 120, height: 120)
                                                }
                                                if let choicedTopping = viewModel.choicedTopping  {
                                                    Image(assetName: "\(choicedTopping.rawValue)")
                                                        .resizable()
                                                        .frame(width: 120, height: 120)
                                                }
                                            }
                                            .offset(x: -50, y: 22)
                                        }
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                VStack{
                                    Spacer()
                                    HStack{
                                        VStack(alignment: .leading){
                                            Spacer()
                                            HStack{
                                                Text(post.title)
                                                    .baeEun(size: 28)
                                                    .foregroundColor(.cardTextMain)
                                                    .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                                Spacer()
                                            }
                                            Text(post.sources)
                                                .baeEun(size: 24)
                                                .foregroundColor(.cardTextMain)
                                                .padding(EdgeInsets(top: 0, leading: 21, bottom: 36, trailing:0))
                                        }
                                        .frame(width: UIScreen.screenWidth * 0.6)
                                        Spacer()
                                    }
                                }
                            }
                        )
                } .frame(width: size.width  - 40, height: size.height * 0.8)
                
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: size.width  - 40, height: size.height * 0.6)
                    .foregroundColor(colorSet.background)
                    .overlay(
                        ZStack {
                            VStack {
                                HStack {
                                    ZStack {
                                        Image(assetName: imageNameAndText.2)
                                            .resizable()
                                            .frame(width: 335, height: 236)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        ZStack {
                                            if let choicedBread = viewModel.choicedBread  {
                                                Image(assetName: "\(choicedBread.rawValue)")
                                                    .resizable()
                                                    .frame(width: 120, height: 120)
                                            }
                                            if let choicedIngredent = viewModel.choicedIngredent  {
                                                Image(assetName: "\(choicedIngredent.rawValue)")
                                                    .resizable()
                                                    .frame(width: 120, height: 120)
                                            }
                                            if let choicedTopping = viewModel.choicedTopping  {
                                                Image(assetName: "\(choicedTopping.rawValue)")
                                                    .resizable()
                                                    .frame(width: 120, height: 120)
                                            }
                                        }
                                        .offset(x: -50, y: 22)
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }
                            VStack{
                                HStack{
                                    HStack{
                                        RoundedRectangle(cornerRadius: 16)
                                            .frame(width: 86, height: 26)
                                            .foregroundColor(.basicGray1BG)
                                            .overlay(
                                                HStack {
                                                    Image(assetName: imageNameAndText.0)
                                                    Text("\(post.hashtags.flavor.rawValue)")
                                                        .pretendardFont(family: .SemiBold, size: 12)
                                                        .foregroundColor(colorSet.icon)
                                                }
                                            )
                                        
                                        RoundedRectangle(cornerRadius: 16)
                                            .frame(width: 86, height: 26)
                                            .foregroundColor(.basicGray1BG)
                                            .overlay(
                                                
                                                HStack {
                                                    Image(assetName: imageNameAndText.1)
                                                    Text("\(post.hashtags.genre.rawValue)")
                                                        .pretendardFont(family: .SemiBold, size: 12)
                                                        .foregroundColor(colorSet.icon)
                                                }
                                            )
                                    }
                                    .padding()
                                    Spacer()
                                }
                                Spacer()
                                HStack{
                                    VStack(alignment: .leading){
                                        Spacer()
                                        HStack{
                                            Text(post.title)
                                                .baeEun(size: 28)
                                                .foregroundColor(.cardTextMain)
                                                .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                            Spacer()
                                        }
                                        Text(post.sources)
                                            .baeEun(size: 24)
                                            .foregroundColor(.cardTextMain)
                                            .padding(EdgeInsets(top: 0, leading: 21, bottom: 36, trailing:0))
                                    }
                                    .frame(width: UIScreen.screenWidth * 0.6)
                                    Spacer()
                                    VStack{
                                        Spacer()
                                        Circle()
                                            .frame(width: 44)
                                            .overlay(
                                                Image(systemName: "square.and.arrow.up")
                                                    .foregroundColor(colorSet.icon)
                                            )
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 16))
                                            .foregroundColor(colorSet.iconBackground)
                                            .onTapGesture {
                                                shareContent(content: shareView.asImage())
                                            }
                                        Circle()
                                            .frame(width: 44)
                                            .overlay(
                                                Image(systemName: "heart")
                                                    .foregroundColor(post.isBookrmark ?  .basicWhite : colorSet.icon)
                                            )
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 16))
                                            .foregroundColor(post.isBookrmark ? colorSet.icon : colorSet.iconBackground)
                                            .onTapGesture {
                                                //북마크하는 로직
                                            }
                                    }
                                }
                            }
                        }
                    )
                
                RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.primaryOrange)
                    .frame(width: 148, height: 54)
                    .overlay(
                        HStack {
                            Image(systemName: "gobackward")
                            Text("다시 만들기")
                        }
                            .foregroundColor(.primaryOrange)
                    )
                    .padding(.top, 10)
                    .onTapGesture {
                        rebakeAction()
                    }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.viewModel.tmpChoicedBread = nil
            self.viewModel.tmpChoicedIngredent = nil
            self.viewModel.tmpChoicedTopping = nil
        }
        
        
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        HStack {
            Spacer()
            Image(systemName: "xmark")
                .foregroundColor(.basicGray8)
                .onTapGesture {
                    backAction()
                }
        }
    }
}
