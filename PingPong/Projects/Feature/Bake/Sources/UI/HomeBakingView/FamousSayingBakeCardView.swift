//
//  FamousSayingBakeCardView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import Model
import SwiftUI
import Authorization

struct FamousSayingBakeCardView: View {
    
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject private var bakeViewModel: BakeViewModel = BakeViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var sheetManager: SheetManager = SheetManager()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    
    
    var backAction: () -> Void
    var rebakeAction: () -> Void
    
    public init(viewModel: CommonViewViewModel, backAction: @escaping () -> Void, rebakeAction: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
        self.rebakeAction = rebakeAction
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                topHeaderBackButton()
                
                Spacer()
                    .frame(height: 17)
                
                // FIXME: Swagger 수정 후 추천 받은 명언으로 카드를 바꿔야합니다 :)
                if let card = viewModel.cards.last {
                    bakeCardView(card: card)
                }
                
                bottomBakeButton()

            }
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.viewModel.tmpChoicedBread = nil
            self.viewModel.tmpChoicedIngredent = nil
            self.viewModel.tmpChoicedTopping = nil
        }
        .task {
            bakeViewModel.bakeQuoteRequest(userId: "423",
                                           flavor: (viewModel.selectFlavor?.type.english) ?? "",
                                           source: (viewModel.selectSource?.type.english) ?? "",
                                           mood: (viewModel.selectMood?.type.english) ?? "")
            authViewModel.searchUserIdRequest(uid: "423")
        }
        .onDisappear {
            self.viewModel.choicedBread = nil
            self.viewModel.choicedIngredent = nil
            self.viewModel.choicedTopping = nil
        }
        
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        ZStack {
            VStack(spacing: .zero) {
                HStack {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width*0.1)
                    
                    Image(asset: .cloud1)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 19, height: 19)
                    
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width*0.1)
                    
                    Text("\(authViewModel.userNickName)을 위한")
                        .pretendardFont(family: .SemiBold, size: 20)
                        .foregroundColor(.primaryOrangeDark)
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 3)
                
                HStack(spacing: .zero) {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width*0.01)
                    
                    Image(asset: .cloud2)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 57, height: 41)
                        .offset(x: -8,y: -10)
                    
                    Text("따근따근한 명언을 구웠어요.")
                        .pretendardFont(family: .SemiBold, size: 20)
                        .foregroundColor(.primaryOrangeDark)
                    
                    Spacer()
                        .frame(width: 14)
                    
                    Image(asset: .cloud3)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .offset(y: -10)
                    
                    
                }
            }
        }
        .padding(.horizontal, 20)
        
        
    }
    
    @ViewBuilder
    private func bakeCardView(card: CardInfomation) -> some View {
        var post = viewModel.generateCardByCondition()
        let size = UIScreen.main.bounds.size
        let colorSet = viewModel.createColorSet(flavor: post.hashtags.flavor)
        
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
                                    Image(assetName: card.hashtags.flavor.type.backgroundImageName1)
                                        .resizable()
                                        .frame(width: 335, height: 236)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    ZStack {
                                        if let choicedBread = viewModel.choicedBread  {
                                            Image(assetName: "\(choicedBread.imageName)")
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                        }
                                        if let choicedIngredent = viewModel.choicedIngredent  {
                                            Image(assetName: "\(choicedIngredent.imageName)")
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                        }
                                        if let choicedTopping = viewModel.choicedTopping  {
                                            Image(assetName: "\(choicedTopping.imageName)")
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
                                    Text(post.author)
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
                                Image(assetName: card.hashtags.flavor.type.backgroundImageName1)
                                    .resizable()
                                    .frame(width: 335, height: 236)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                ZStack {
                                    if let choicedBread = viewModel.choicedBread  {
                                        Image(assetName: "\(choicedBread.imageName)")
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                    }
                                    if let choicedIngredent = viewModel.choicedIngredent  {
                                        Image(assetName: "\(choicedIngredent.imageName)")
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                    }
                                    if let choicedTopping = viewModel.choicedTopping  {
                                        Image(assetName: "\(choicedTopping.imageName)")
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
                                HStack {
                                    Image(assetName: card.hashtags.source.type.korean)
                                    Text("\(post.hashtags.flavor.rawValue)")
                                        .pretendardFont(family: .SemiBold, size: 12)
                                }
                                .foregroundColor(colorSet.icon)
                                .frame(minWidth: 41, maxHeight: 26)
                                .padding(.horizontal, 10)
                                .background (
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(.basicGray1BG)
                                )
                                
                                HStack {
                                    Image(assetName: card.hashtags.source.type.smallIconImageName)
                                    Text("\(post.hashtags.source.rawValue)")
                                        .pretendardFont(family: .SemiBold, size: 12)
                                        .foregroundColor(colorSet.icon)
                                }
                                .frame(minWidth: 41, maxHeight: 26)
                                .padding(.horizontal, 10)
                                .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(.basicGray1BG)
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
                                Text(post.author)
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
                                        SharedManger.shared.shareContent(content: shareView.asImage())
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
//                                                let postIndex = viewModel.searchPostIndex(post: post)
//                                                viewModel.homePosts[postIndex].isBookrmark.toggle()
                                        
                                        post.isBookrmark.toggle()
                                    }
                            }
                        }
                    }
                }
            )
    }
    
    @ViewBuilder
    private func bottomBakeButton() -> some View {
        HStack(spacing: .zero) {
            Spacer()
            
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color.primaryOrange)
                .frame(width: 148, height: 54)
                .overlay(
                    HStack {
                        Image(asset: .backAgain)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("다시 만들기")
                            .pretendardFont(family: .SemiBold, size: 16)
                            .kerning(-0.41)
                            .foregroundColor(Color.primaryOrange)
                        
                    }
                        .foregroundColor(.primaryOrange)
                )
                .padding(.top, 10)
                .onTapGesture {
                    self.viewModel.selectFlavor = nil
                    self.viewModel.selectSource = nil
                    self.viewModel.selectMood = nil
                    rebakeAction()
                }
            
            Spacer()
                .frame(width: 14)
            
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color.primaryOrange)
                .frame(width: 148, height: 54)
                .overlay(
                    HStack {
                        Image(asset: .bakeHome)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("홈으로 가기")
                            .pretendardFont(family: .SemiBold, size: 16)
                            .kerning(-0.41)
                            .foregroundColor(Color.primaryOrange)
                        
                    }
                )
                .padding(.top, 10)
                .onTapGesture {
                    backAction()
                }
            
            Spacer()
        }
    }
    
}
