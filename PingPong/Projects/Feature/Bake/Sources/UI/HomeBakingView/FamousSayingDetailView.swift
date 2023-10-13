//
//  FamousSayingDetailView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/08.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import SwiftUI

struct FamousSayingDetailView: View {
    let shareManager = SharedManger.shared
    @StateObject private var viewModel: CommonViewViewModel
    
    public init(viewModel: CommonViewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        let shareView =     VStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(viewModel.detailViewInfo.colorSet.background)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.6)
                .overlay(
                    ZStack {
                        VStack {
                            HStack {
                                ZStack {
                                    Image(assetName: viewModel.detailViewInfo.imageNameAndText.userCustomMoodImageName)
                                        .resizable()
                                        .frame(width: 335, height: 236)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    ZStack {
                                        Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.userCustomSourceIconImageName)")
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                        Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.userCustomFlavorImageName)")
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                        Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.userCustomBackgroundImageName)")
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
                                        Text(viewModel.detailViewInfo.cardInfomation.title)
                                            .baeEun(size: 28)
                                            .foregroundColor(.cardTextMain)
                                            .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                        Spacer()
                                    }
                                    Text(viewModel.detailViewInfo.cardInfomation.sources)
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
                    .foregroundColor(viewModel.detailViewInfo.colorSet.background)
                    .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenHeight * 0.6)
                    .overlay(
                        ZStack {
                            VStack {
                                HStack {
                                    ZStack {
                                        Image(assetName: viewModel.detailViewInfo.imageNameAndText.userCustomMoodImageName)
                                            .resizable()
                                            .frame(width: 335, height: 236)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        ZStack {
                                            Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.userCustomSourceIconImageName)")
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                            Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.userCustomFlavorImageName)")
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                            Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.userCustomBackgroundImageName)")
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
                                            Image(assetName: viewModel.detailViewInfo.imageNameAndText.userCustomFlavorImageName)
                                            Text("\(viewModel.detailViewInfo.cardInfomation.hashtags.flavor.rawValue)")
                                                .pretendardFont(family: .SemiBold, size: 12)
                                        }
                                        .foregroundColor(viewModel.detailViewInfo.colorSet.icon)
                                        .frame(minWidth: 41, maxHeight: 26)
                                        .padding(.horizontal, 10)
                                        .background (
                                        RoundedRectangle(cornerRadius: 16)
                                            .foregroundColor(.basicGray1BG)
                                        )
                                        
                                        HStack {
                                            Image(assetName: viewModel.detailViewInfo.imageNameAndText.userCustomSourceIconImageName)
                                            Text("\(viewModel.detailViewInfo.cardInfomation.hashtags.source.rawValue)")
                                                .pretendardFont(family: .SemiBold, size: 12)
                                                .foregroundColor(viewModel.detailViewInfo.colorSet.icon)
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
                                            Text(viewModel.detailViewInfo.cardInfomation.title)
                                                .baeEun(size: 28)
                                                .foregroundColor(.cardTextMain)
                                                .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                            Spacer()
                                        }
                                        Text(viewModel.detailViewInfo.cardInfomation.sources)
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
                                                    .foregroundColor(viewModel.detailViewInfo.colorSet.icon)
                                            )
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 16))
                                            .foregroundColor(viewModel.detailViewInfo.colorSet.iconBackground)
                                            .onTapGesture {
                                                shareManager.shareContent(content: shareView.asImage())
                                            }
                                        Circle()
                                            .frame(width: 44)
                                            .overlay(
                                                Image(systemName: "heart")
                                                    .foregroundColor(viewModel.detailViewInfo.cardInfomation.isBookrmark ?  .basicWhite : viewModel.detailViewInfo.colorSet.icon)
                                            )
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 16))
                                            .foregroundColor(viewModel.detailViewInfo.cardInfomation.isBookrmark ? viewModel.detailViewInfo.colorSet.icon : viewModel.detailViewInfo.colorSet.iconBackground)
                                            .onTapGesture {
                                                let postIndex = viewModel.searchPostIndex(cardInfomation: viewModel.detailViewInfo.cardInfomation)
                                                viewModel.cards[postIndex].isBookrmark.toggle()
                                                
                                                viewModel.detailViewInfo.cardInfomation.isBookrmark.toggle()
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
