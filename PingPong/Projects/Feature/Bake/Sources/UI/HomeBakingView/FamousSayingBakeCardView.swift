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
    @StateObject private var bakeViewModel: BakeViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var sheetManager: SheetManager = SheetManager()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    
    
    var backAction: () -> Void
    var rebakeAction: () -> Void
    
    public init(viewModel: CommonViewViewModel,
                bakeViewModel: BakeViewModel,
                backAction: @escaping () -> Void,
                rebakeAction: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._bakeViewModel = StateObject(wrappedValue: bakeViewModel)
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
                if let card = bakeViewModel.bakeCard {
                    bakeCardView()
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
//            await bakeViewModel.bakeQuoteRequest(userId: "\(authViewModel.userid)",
//                                           flavor: (viewModel.selectFlavor?.type.english) ?? "",
//                                           source: (viewModel.selectSource?.type.english) ?? "",
//                                           mood: (viewModel.selectMood?.type.english) ?? "")
            authViewModel.searchUserIdRequest(uid: "\(authViewModel.userid)")
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
    private func bakeCardView() -> some View {
        let size = UIScreen.main.bounds.size
        let colorSet = viewModel.createColorSet(flavor: bakeViewModel.bakeCard?.hashtags.flavor ?? Flavor.light)
        
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
                                    Image(assetName: bakeViewModel.bakeCard?.hashtags.flavor.type.backgroundImageName1 ?? "")
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
                                        Text(bakeViewModel.bakeCard?.title ?? "")
                                            .baeEun(size: 28)
                                            .foregroundColor(.cardTextMain)
                                            .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                        Spacer()
                                    }
                                    Text(bakeViewModel.bakeCard?.author ?? "")
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
                                Image(assetName: bakeViewModel.bakeCard?.hashtags.flavor.type.backgroundImageName1 ?? "")
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
                                    Image(assetName: bakeViewModel.bakeCard?.hashtags.flavor.type.smallIconImageName ?? "")
                                    Text("\(bakeViewModel.bakeCard?.hashtags.flavor.type.korean ?? "")")
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
                                    Image(assetName: bakeViewModel.bakeCard?.hashtags.source.type.smallIconImageName ?? "")
                                    Text("\(bakeViewModel.bakeCard?.hashtags.source.type.korean ?? "")")
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
                                    Text(bakeViewModel.bakeCard?.title ?? "")
                                        .baeEun(size: 28)
                                        .foregroundColor(.cardTextMain)
                                        .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                    Spacer()
                                }
                                Text(bakeViewModel.bakeCard?.author ?? "")
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
                                            .foregroundColor(bakeViewModel.bakeCard?.isBookrmark ?? true ?  .basicWhite : colorSet.icon)
                                    )
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 16))
                                    .foregroundColor(bakeViewModel.bakeCard?.isBookrmark ?? true ? colorSet.icon : colorSet.iconBackground)
                                    .onTapGesture {
                                        
                                        if bakeViewModel.bakeCard != nil {
                                        if bakeViewModel.bakeCard!.isBookrmark {
                                            Task {
                                                if let likeId = bakeViewModel.bakeCard?.likeId {
                                                    await viewModel.deleteLikeQuote(likeID: likeId)
                                                    bakeViewModel.bakeCard!.isBookrmark = false
                                                }
                                            }
                                        } else {
                                            Task {
                                                await viewModel.quoteLikeRequest(userID: "\(authViewModel.userid)", quoteId: bakeViewModel.bakeCard!.qouteId) {
                                                    bakeViewModel.bakeCard?.likeId = likeId
                                                }
                                                bakeViewModel.bakeCard!.isBookrmark = true
                                                
                                            }
                                        }
                                        }
                                            //TODO: 좋아요되도록 수정
                                            //                                        post.isBookrmark.toggle()
//                                            print("togggle ->>>> \(cardinfo.isBookrmark)")
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
