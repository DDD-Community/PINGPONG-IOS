
//
//  HomeView.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Bake
import Common
import DesignSystem
import SwiftUI
import Model

public struct HomeView: View {
    
    @State var currentIndex: Int = 0
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject private var homeViewModel: HomeViewViewModel = HomeViewViewModel()
    @StateObject var appState: AppState = AppState()
    
    @State var isOn: [Bool] = []
    public init(viewModel: CommonViewViewModel) {
        //TODO: dummy 수정 = viewModel.homePosts
        self._isOn = State(initialValue: Array(repeating: false, count: viewModel.cards.count))
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack{
            VStack{
                
                carouselRandomQuoteView()
                
                bakeBreadButton
                
            }
            .navigationBarHidden(true)
            
            .onAppear {
                if !isOn.isEmpty {
                    self.isOn[0] = true
                    homeViewModel.randomQuoteRequest(userID: "423") { data in
                        print(data)
                        CommonViewViewModel.cards.append(CardInfomation(stageNum: 0, hashtags: <#T##Hashtags#>, image: <#T##String#>, title: <#T##String#>, sources: <#T##String#>, isBookrmark: <#T##Bool#>))
                    }
                } else {
                    homeViewModel.randomQuoteRequest(userID: "423") { data  in
                        print(data)
                    }
                }
            }
        }
        
        .navigationDestination(isPresented: $appState.goToBackingView) {
            HomeBakingView(viewModel: viewModel, appState: appState, backAction: {
                appState.goToBackingView = false
            })
        }
        
        
    }
    
    @ViewBuilder
    private func carouselRandomQuoteView() -> some View {
        if let contents = homeViewModel.homeRandomQuoteModel?.data?.content {
            SnapCarousel(index: $currentIndex, items: contents, isOn : $isOn ) { post in
                
                let hashTags = homeViewModel.getHashtags(post: post)
                
                let imageNameAndText = self.viewModel.generateImageNameAndText(hashtags: hashTags)
                
                GeometryReader{ proxy in
                    let size = proxy.size
                    let colorSet = viewModel.searchCharacterColor(flavor: hashTags.flavor)
                    
                    let shareView = shareView(colorSet: colorSet, size: size, imageNameAndText: imageNameAndText, post: post)
                    
                    
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: size.width, height: size.height * 0.62)
                        .foregroundColor(colorSet.background)
                        .overlay(
                            ZStack {
                                usercustomBreadView(imageNameAndText: imageNameAndText)
                                
                                VStack{
                                    hashTagsView(colorSet: colorSet, hashTags: hashTags, imageNameAndText: imageNameAndText)
                                    Spacer()
                                    HStack{
                                        VStack(alignment: .leading){
                                            Spacer()
                                            HStack{
                                                Text(post.content ?? "")
                                                    .baeEun(size: 28)
                                                    .foregroundColor(.cardTextMain)
                                                    .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                                Spacer()
                                            }
                                            Text(post.author ?? "")
                                                .baeEun(size: 24)
                                                .foregroundColor(.cardTextMain)
                                                .padding(EdgeInsets(top: 0, leading: 21, bottom: 36, trailing:0))
                                        }
                                        .frame(width: UIScreen.screenWidth * 0.6)
                                        
                                        Spacer()
                                        cardSideView(colorSet: colorSet, post: post, shareView: shareView)
                                    }
                                }
                            }
                        )
                }
                
                
            }
            .frame(height: UIScreen.screenHeight * 0.64)
        }
        
    }
    
    private var bakeBreadButton: some View {
        RoundedRectangle(cornerRadius: UIScreen.screenWidth * 0.12)
            .fill(Color.primaryOrange)
            .frame(width: UIScreen.screenWidth * 0.6, height: 60, alignment: .center)
            .overlay {
                HStack{
                    Image(assetName: "bread")
                        .padding(0)
                    Text("오늘의 명언 굽기")
                        .foregroundColor(.white)
                        .pretendardFont(family: .SemiBold, size: 16)
                }
            }
            .onTapGesture {
                appState.goToBackingView = true
                print("버튼 \(appState.goToBackingView)")
                
            }
    }
    
    @ViewBuilder
    private func usercustomBreadView(imageNameAndText: UserCustomBreadViewInfo) -> some View {
        VStack {
            HStack {
                ZStack {
                    Image(assetName: imageNameAndText.userCustomBackgroundImageName)
                        .resizable()
                        .frame(width: 335, height: 236)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    ZStack {
                        Image(assetName: "carousel\(imageNameAndText.userCustomSourceIconImageName)")
                            .resizable()
                            .frame(width: 120, height: 120)
                        Image(assetName: "carousel\(imageNameAndText.userCustomFlavorImageName)")
                            .resizable()
                            .frame(width: 120, height: 120)
                        Image(assetName: "carousel\(imageNameAndText.userCustomMoodImageName)")
                            .resizable()
                            .frame(width: 120, height: 120)
                    }
                    .offset(x: -50, y: 22)
                }
                Spacer()
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func shareView(colorSet: CharacterColor, size: CGSize, imageNameAndText: UserCustomBreadViewInfo, post: QuoteContent) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(colorSet.background)
                .frame(width: size.width, height: size.height * 0.6)
                .overlay(
                    ZStack {
                        usercustomBreadView(imageNameAndText: imageNameAndText)
                        
                        VStack{
                            Spacer()
                            
                            HStack{
                                VStack(alignment: .leading){
                                    
                                    Spacer()
                                    
                                    HStack{
                                        Text(post.content ?? "")
                                            .baeEun(size: 28)
                                            .foregroundColor(.cardTextMain)
                                            .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                        Spacer()
                                    }
                                    Text(post.source ?? "")
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
        }
        .frame(width: size.width, height: size.height * 0.8)
    }
    
    @ViewBuilder
    func hashTagsView(colorSet: CharacterColor, hashTags: Hashtags, imageNameAndText: UserCustomBreadViewInfo) -> some View {
        HStack{
            HStack{
                HStack {
                    Image(assetName: imageNameAndText.userCustomFlavorImageName)
                    Text("\(hashTags.flavor.type.korean)")
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
                    Image(assetName: imageNameAndText.userCustomSourceIconImageName)
                    Text("\(hashTags.source.type.korean)")
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
    }
    
    @ViewBuilder
    func cardSideView(colorSet: CharacterColor, post: QuoteContent, shareView: any View) -> some View {
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
                        .foregroundColor(post.likeYn ?? false ?  .basicWhite : colorSet.icon)
                )
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 16))
                .foregroundColor(post.likeYn ?? false ? colorSet.icon : colorSet.iconBackground)
            //                                                .onTapGesture {
            //                                                    let postIndex = post.quoteID
            //                                                    viewModel.homePosts[postIndex ?? .zero].isBookrmark.toggle()
            //                                                    homeViewModel.userPrefRequest(userID: "403", quoteId: post.quoteID ?? .zero, isScarp: false)
            //                                                    homeViewModel.userPrefRequest(userID: "403", quoteId: post.quoteID ?? .zero, isScarp: true)
            //                                                }
        }
    }
}


private func shareContent(content: UIImage) {
    let avc = UIActivityViewController(activityItems: [content], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
}



