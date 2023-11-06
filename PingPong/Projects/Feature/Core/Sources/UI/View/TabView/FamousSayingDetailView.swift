//
//  FamousSayingDetailView.swift
//  Core
//
//  Created by Byeon jinha on 2023/11/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import Model
import SwiftUI
import Authorization

public struct FamousSayingDetailView: View {
    let shareManager = SharedManger.shared
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject private var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    let colorSet: FlavorColor
    
    public init(viewModel: CommonViewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.colorSet = viewModel.createColorSet(flavor: viewModel.selectedCard.hashtags.flavor)
    }
    
    public var body: some View {
        let shareView = VStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(colorSet.background)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.6)
                .overlay(
                    ZStack {
                        VStack {
                            HStack {
                                ZStack {
                                    Image(assetName: viewModel.selectedCard.hashtags.flavor.type.backgroundImageName1)
                                        .resizable()
                                        .frame(width: 335, height: 236)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    ZStack {
                                        Image(assetName: viewModel.selectedCard.hashtags.source.type.bread.imageName)
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                        Image(assetName: viewModel.selectedCard.hashtags.flavor.type.ingredent.imageName)
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                        Image(assetName: viewModel.selectedCard.hashtags.mood.type.topping.imageName)
                                            .resizable()
                                            .frame(width: 120, height: 120)
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
                                        Text(viewModel.selectedCard.title)
                                            .baeEun(size: 28)
                                            .foregroundColor(.cardTextMain)
                                            .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                        Spacer()
                                    }
                                    Text(viewModel.selectedCard.author)
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
        } .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.8)

        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(colorSet.background)
                    .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenHeight * 0.6)
                    .overlay(
                        ZStack {
                            VStack {
                                HStack {
                                    ZStack {
                                        Image(assetName: viewModel.selectedCard.hashtags.flavor.type.backgroundImageName1)
                                            .resizable()
                                            .frame(width: 335, height: 236)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        ZStack {
                                            Image(assetName: viewModel.selectedCard.hashtags.source.type.bread.imageName)
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                            Image(assetName: viewModel.selectedCard.hashtags.flavor.type.ingredent.imageName)
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                            Image(assetName: viewModel.selectedCard.hashtags.mood.type.topping.imageName)
                                                .resizable()
                                                .frame(width: 120, height: 120)
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
                                            Image(assetName: viewModel.selectedCard.hashtags.flavor.type.smallIconImageName)
                                            Text(viewModel.selectedCard.hashtags.flavor.type.korean)
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
                                            Image(assetName: viewModel.selectedCard.hashtags.source.type.smallIconImageName)
                                            Text(viewModel.selectedCard.hashtags.source.type.korean)
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
                                            Text(viewModel.selectedCard.title)
                                                .baeEun(size: 28)
                                                .foregroundColor(.cardTextMain)
                                                .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                            Spacer()
                                        }
                                        Text(viewModel.selectedCard.author)
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
                                                shareManager.shareContent(content: shareView.asImage())
                                            }
                                        Circle()
                                            .frame(width: 44)
                                            .overlay(
                                                Image(systemName: "heart")
                                                    .foregroundColor(viewModel.selectedCard.isBookrmark ? .basicWhite : colorSet.icon)
                                            )
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 16))
                                            .foregroundColor(viewModel.selectedCard.isBookrmark ? colorSet.icon : colorSet.iconBackground)
                                            .onTapGesture {
                                                self.viewModel.likeYn.toggle()
                                                
                                                if let idx = viewModel.cards.firstIndex(of: viewModel.selectedCard) {
                                                    
                                                    //FIXME: quteId 수정 후 해당 로직 수정
                                                    viewModel.cards[idx].isBookrmark.toggle()
                                                    Task {
                                                    await viewModel.quoteLikeRequest(userID: "\(authViewModel.userid)", quoteId: viewModel.selectedCard.qouteId)
                                                    }
                                                }
                                            }
                                    }
                                }
                            }
                        }
                    )
            } .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.8)
        }
    }
}
