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
                                    Image(assetName: viewModel.detailViewInfo.imageNameAndText.2)
                                        .resizable()
                                        .frame(width: 335, height: 236)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    ZStack {
                                        Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.1)")
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                        Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.0)")
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                        Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.3)")
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
                                        Text(viewModel.detailViewInfo.post.title)
                                            .baeEun(size: 28)
                                            .foregroundColor(.cardTextMain)
                                            .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                        Spacer()
                                    }
                                    Text(viewModel.detailViewInfo.post.sources)
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
                                        Image(assetName: viewModel.detailViewInfo.imageNameAndText.2)
                                            .resizable()
                                            .frame(width: 335, height: 236)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        ZStack {
                                            Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.1)")
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                            Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.0)")
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                            Image(assetName: "carousel\(viewModel.detailViewInfo.imageNameAndText.3)")
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
                                            Image(assetName: viewModel.detailViewInfo.imageNameAndText.0)
                                            Text("\(viewModel.detailViewInfo.post.hashtags.flavor.rawValue)")
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
                                            Image(assetName: viewModel.detailViewInfo.imageNameAndText.1)
                                            Text("\(viewModel.detailViewInfo.post.hashtags.source.rawValue)")
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
                                            Text(viewModel.detailViewInfo.post.title)
                                                .baeEun(size: 28)
                                                .foregroundColor(.cardTextMain)
                                                .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                            Spacer()
                                        }
                                        Text(viewModel.detailViewInfo.post.sources)
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
                                                    .foregroundColor(viewModel.detailViewInfo.post.isBookrmark ?  .basicWhite : viewModel.detailViewInfo.colorSet.icon)
                                            )
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 16))
                                            .foregroundColor(viewModel.detailViewInfo.post.isBookrmark ? viewModel.detailViewInfo.colorSet.icon : viewModel.detailViewInfo.colorSet.iconBackground)
                                            .onTapGesture {
                                                let postIndex = viewModel.searchPostIndex(post: viewModel.detailViewInfo.post)
                                                viewModel.homePosts[postIndex].isBookrmark.toggle()
                                                
                                                viewModel.detailViewInfo.post.isBookrmark.toggle()
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
