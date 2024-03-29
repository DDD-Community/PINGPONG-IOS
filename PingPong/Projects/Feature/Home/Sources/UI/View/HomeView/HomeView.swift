
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
import Collections
import Authorization
import PopupView


public struct HomeView: View {
    
    @State var currentIndex: Int = 0
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject private var homeViewModel: HomeViewViewModel = HomeViewViewModel()
    @StateObject private var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
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
                
                if homeViewModel.homeViewLoading {
                    LoadingView()
                    
                } else {
                    carouselRandomQuoteView()
                    
                    bakeBreadButton
                }
                
            }
            .navigationBarHidden(true)
            .task {
//                Task {
//                    await authViewModel.loginWithEmail(email: authViewModel.userEmail, succesCompletion: { model in
//                        authViewModel.userNickName = model.data?.nickname ?? ""
//                        authViewModel.userid = String(model.data?.id ?? .zero)
//                        print("userid \(authViewModel.userid)")
//                    }, failLoginCompletion: {
//                        authViewModel.userid = ""
//                    })
//                    authViewModel.searchUserIdRequest(uid: "\(authViewModel.userid)", failCompletion: {
//                        authViewModel.userid = ""
//                    })
//                }
                
                if !homeViewModel.isOn.isEmpty {
                    homeViewModel.randomQuoteRequest(userID: "\(authViewModel.userid)") { model in
                        for quoteContent in model.data?.content ?? [] {
                            let hashTags = viewModel.getHashtags(post: quoteContent)
                            self.homeViewModel.isOn[quoteContent.quoteID ?? .zero].toggle()
                            self.homeViewModel.selecteLikeYn = quoteContent.likeID != nil
                            
                            let card = CardInfomation(qouteId: quoteContent.quoteID ?? .zero,
                                                      hashtags: hashTags, image: "",
                                                      title: quoteContent.content ?? "",
                                                      sources: quoteContent.author ?? "",
                                                      isBookrmark: quoteContent.likeID != nil,
                                                      likeId: quoteContent.likeID
                            )
                            if !viewModel.cards.contains(card) {
                                viewModel.cards.append(card)
                            }
                            
                            
                        }
                    }
                }  else if authViewModel.userid == "" || authViewModel.userid == "0" || authViewModel.userid != authViewModel.userid {
                    viewModel.cards = []
                    homeViewModel.randomQuoteRequest(userID: "") { model in
                        for quoteContent in model.data?.content ?? [] {
                            let hashTags = viewModel.getHashtags(post: quoteContent)
                            self.homeViewModel.selecteLikeYn = quoteContent.likeID != nil
                            let card = CardInfomation(qouteId: quoteContent.quoteID ?? .zero,
                                                      hashtags: hashTags, image: "",
                                                      title: quoteContent.content ?? "",
                                                      sources: quoteContent.author ?? "",
                                                      isBookrmark: quoteContent.likeID != nil,
                                                      likeId: quoteContent.likeID
                            )
                            if !viewModel.cards.contains(card) {
                                viewModel.cards.append(card)
                            }
                        }
                    }
                } else {
                    homeViewModel.randomQuoteRequest(userID: "\(authViewModel.userid)") { model in
                        for quoteContent in model.data?.content ?? [] {
                            let hashTags = viewModel.getHashtags(post: quoteContent)
                            self.homeViewModel.selecteLikeYn = quoteContent.likeID != nil
                            let card = CardInfomation(qouteId: quoteContent.quoteID ?? .zero,
                                                      hashtags: hashTags, image: "",
                                                      title: quoteContent.content ?? "",
                                                      sources: quoteContent.author ?? "",
                                                      isBookrmark: quoteContent.likeID != nil,
                                                      likeId: quoteContent.likeID
                            )
                            
                            if !viewModel.cards.contains(card) {
                                viewModel.cards.append(card)
                            }
                        }
                    }
                }
                
            }
            
            .onAppear {
//                if !homeViewModel.isOn.isEmpty {
//                    homeViewModel.randomQuoteRequest(userID: "\(authViewModel.userid)") { model in
//                        for quoteContent in model.data?.content ?? [] {
//                            let hashTags = viewModel.getHashtags(post: quoteContent)
//                            self.homeViewModel.isOn[quoteContent.quoteID ?? .zero].toggle()
//                            self.homeViewModel.selecteLikeYn = quoteContent.likeID != nil
//                            
//                            let card = CardInfomation(qouteId: quoteContent.quoteID ?? .zero,
//                                                      hashtags: hashTags, image: "",
//                                                      title: quoteContent.content ?? "",
//                                                      sources: quoteContent.author ?? "",
//                                                      isBookrmark: quoteContent.likeID != nil,
//                                                      likeId: quoteContent.likeID
//                            )
//                            if !viewModel.cards.contains(card) {
//                                viewModel.cards.append(card)
//                            }
//                            
//                            
//                        }
//                    }
//                } else {
//                    homeViewModel.randomQuoteRequest(userID: "\(authViewModel.userid)") { model in
//                        for quoteContent in model.data?.content ?? [] {
//                            let hashTags = viewModel.getHashtags(post: quoteContent)
//                            self.homeViewModel.selecteLikeYn = quoteContent.likeID != nil
//                            let card = CardInfomation(qouteId: quoteContent.quoteID ?? .zero,
//                                                      hashtags: hashTags, image: "",
//                                                      title: quoteContent.content ?? "",
//                                                      sources: quoteContent.author ?? "",
//                                                      isBookrmark: quoteContent.likeID != nil,
//                                                      likeId: quoteContent.likeID
//                            )
//                            if !viewModel.cards.contains(card) {
//                                viewModel.cards.append(card)
//                            }
//                        }
//                    }
//                }
            }
            .onChange(of: viewModel.selectedCard.isBookrmark , perform: { newValue in
                if viewModel.isLoginCheck {
                    homeViewModel.randomQuoteRequest(userID: "\(authViewModel.userid)") { model in
                        // 종아요일 때
                        
                        for quoteContent in model.data?.content ?? [] {
                            let hashTags = viewModel.getHashtags(post: quoteContent)
                            viewModel.cards.append(CardInfomation(qouteId: quoteContent.quoteID ?? .zero, hashtags: hashTags, image: "", title: quoteContent.content ?? "", sources: quoteContent.author ?? "", isBookrmark: newValue, likeId: quoteContent.likeID))
                            
                        }
                    }
                }
            })
        }
        
        .navigationDestination(isPresented: $appState.goToBackingView) {
            HomeBakingView(viewModel: viewModel, appState: appState, backAction: {
                appState.goToBackingView = false
            })
        }
    }
    
    @ViewBuilder
    private func carouselRandomQuoteView() -> some View {
        SnapCarousel(index: $currentIndex, items: viewModel.cards, isOn : $viewModel.isOn ) { card in
            
            GeometryReader{ proxy in
                let size = proxy.size
                let colorSet = viewModel.createColorSet(flavor: card.hashtags.flavor)
                
                let shareView = shareView(colorSet: colorSet, size: size, card: card)
                
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: size.width, height: size.height * 0.62)
                    .foregroundColor(colorSet.background)
                    .overlay(
                        ZStack {
                            userCustomBreadView(hashtags: card.hashtags)
                            
                            VStack{
                                hashTagsView(colorSet: colorSet, hashtags: card.hashtags)
                                Spacer()
                                
                                HStack{
                                    VStack(alignment: .leading){
                                        Spacer()
                                        HStack{
                                            Text(card.title)
                                                .baeEun(size: 28)
                                                .foregroundColor(.cardTextMain)
                                                .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                            Spacer()
                                        }
                                        Text(card.author)
                                            .baeEun(size: 24)
                                            .foregroundColor(.cardTextMain)
                                            .padding(EdgeInsets(top: 0, leading: 21, bottom: 36, trailing:0))
                                    }
                                    .frame(width: UIScreen.screenWidth * 0.6)
                                    
                                    Spacer()
                                    cardSideView(colorSet: colorSet, card: card, shareView: shareView)
                                }
                            }
                        }
                    )
            }
            
            
        }
        .frame(height: UIScreen.screenHeight * 0.64)
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
                if viewModel.isLoginCheck {
                    appState.goToBackingView = true
                } else {
                    viewModel.isLoginExplore = true
                }
            }
    }
    
    @ViewBuilder
    private func userCustomBreadView(hashtags: Hashtags) -> some View {
        VStack {
            HStack {
                ZStack {
                    Image(assetName: hashtags.flavor.type.backgroundImageName1)
                        .resizable()
                        .frame(width: 335, height: 236)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    ZStack {
                        Image(assetName: hashtags.source.type.bread.imageName)
                            .resizable()
                            .frame(width: 120, height: 120)
                        Image(assetName: hashtags.flavor.type.ingredent.imageName)
                            .resizable()
                            .frame(width: 120, height: 120)
                        Image(assetName: hashtags.mood.type.topping.imageName)
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
    private func shareView(colorSet: FlavorColor, size: CGSize, card: CardInfomation) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(colorSet.background)
                .frame(width: size.width, height: size.height * 0.6)
                .overlay(
                    ZStack {
                        userCustomBreadView(hashtags: card.hashtags)
                        
                        VStack{
                            Spacer()
                            
                            HStack{
                                VStack(alignment: .leading){
                                    
                                    Spacer()
                                    
                                    HStack{
                                        Text(card.title)
                                            .baeEun(size: 28)
                                            .foregroundColor(.cardTextMain)
                                            .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                        Spacer()
                                    }
                                    Text(card.author)
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
    func hashTagsView(colorSet: FlavorColor, hashtags: Hashtags) -> some View {
        HStack{
            HStack{
                HStack {
                    Image(assetName: hashtags.flavor.type.smallIconImageName)
                    Text("\(hashtags.flavor.type.korean)")
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
                    Image(assetName: hashtags.source.type.smallIconImageName)
                    Text("\(hashtags.source.type.korean)")
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
    func cardSideView(colorSet: FlavorColor, card: CardInfomation, shareView: any View) -> some View {
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
                        .foregroundColor(card.isBookrmark ? .basicWhite : colorSet.icon)
                )
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 16))
                .foregroundColor(card.isBookrmark ? colorSet.icon : colorSet.iconBackground)
                .onTapGesture {
                    if viewModel.isLoginCheck {
                        if let idx = viewModel.cards.firstIndex(of: card) {
                            if viewModel.cards[idx].isBookrmark {
                                Task {
                                    if let likeId = viewModel.cards[idx].likeId {
                                        await viewModel.deleteLikeQuote(likeID: likeId)
                                        viewModel.cards[idx].isBookrmark = false
                                    }
                                }
                            } else {
                                Task {
                                    await viewModel.quoteLikeRequest(userID: "\(authViewModel.userid)", quoteId: card.qouteId, completion: {})
                                    viewModel.cards[idx].isBookrmark = true
                                }
                            }
                        }
                    }
                    else {
                        viewModel.isLoginExplore = true
                    }
                }
        }
    }
}


private func shareContent(content: UIImage) {
    let avc = UIActivityViewController(activityItems: [content], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
}



