//
//  ArchiveView.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Bake
import Common
import DesignSystem
import Model
import SwiftUI
import Authorization

public struct ArchiveView: View {
    
    @StateObject var viewModel: CommonViewViewModel
    @StateObject var archiveViewViewModel: ArchiveViewViewModel = ArchiveViewViewModel()
    @StateObject var appState: AppState = AppState()
    @StateObject var authViewViewModel: AuthorizationViewModel = AuthorizationViewModel()
    
    public init(viewModel: CommonViewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @EnvironmentObject var sheetManager: SheetManager
    
    let columns = [
        GridItem(.fixed(175)),   GridItem(.fixed(175))
    ]
    
    let buttonHeight: CGFloat = 30
    
    public var body: some View {
        VStack(){
            archiveHeader()
            
            staticsView(count: viewModel.bookmarkCards.count)
            
            if !viewModel.bookmarkCards.isEmpty {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.bookmarkCards) { card in
                            let colorSet = viewModel.createColorSet(flavor: card.hashtags.flavor)
                            VStack {
                                HStack {
                                    Circle()
                                        .foregroundColor(colorSet.iconBackground)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Image(assetName: card.hashtags.flavor.type.smallIconImageName)
                                                .resizable()
                                                .frame(width: 14, height: 14)
                                        )
                                    Circle()
                                        .foregroundColor(colorSet.iconBackground)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Image(assetName: card.hashtags.source.type.smallIconImageName)
                                                .resizable()
                                                .frame(width: 14, height: 14)
                                        )
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 0))
                                
                                Spacer()
                                
                                HStack {
                                    Text(card.title)
                                        .baeEun(size: 18)
                                        .foregroundColor(.cardTextMain)
                                        .allowsTightening(true)
                                        .padding()
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(card.author)
                                        .baeEun(size: 18)
                                        .foregroundColor(.cardTextMain)
                                        .padding()
                                    Spacer()
                                }
                            }
                            .frame(width: 175, height: 240, alignment: .leading)
                            .background(colorSet.background)
                            .allowsTightening(true)
                            .cornerRadius(10)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedCard = card
                                    viewModel.isShowDetailView.toggle()
                                }
                            }
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.56)
            } else {
                VStack(alignment: .center){
                    Image(assetName: "archiveEmptyImage")
                        .resizable()
                        .frame(width: 200, height: 80)
                    Text("저장된 명언이 없네요!")
                    Text("오늘의 명언을 만들러 가볼까요?")
                    
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
                            appState.goToBackingView.toggle()
                        }
                }
                .pretendardFont(family: .SemiBold, size: 18)
                .frame(height: UIScreen.main.bounds.height * 0.56)
            }
        }
        .navigationDestination(isPresented: $appState.goToBackingView) {
            HomeBakingView(viewModel: viewModel, appState: appState, backAction: {
                appState.goToBackingView = false
            })
        }
        .task {
            await viewModel.archiveRequest(userId: "\(authViewViewModel.userid)") {
                viewModel.bookmarkCards = []
                for quoteContent in viewModel.archiveModel?.data ?? [] {
                    let hashTags = viewModel.getHashtags(post: quoteContent)
                    //FIXME: archive api 수정 요청
                    let card = CardInfomation(qouteId: quoteContent.quoteID ?? .zero,
                                              hashtags: hashTags, image: "",
                                              title: quoteContent.content ?? "",
                                              sources: quoteContent.author ?? "",
                                              isBookrmark: quoteContent.likeID != nil,
                                              likeId: quoteContent.likeID
                    )
                    viewModel.bookmarkCards.append(card)
                }
            }
        }
    }
    @ViewBuilder
    private func archiveHeader() -> some View {
        Image(assetName: "archiveViewBG")
            .resizable()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.screenHeight * 0.2)
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Text("보관함")
                            .padding()
                            .pretendardFont(family: .SemiBold, size: 24)
                            .foregroundColor(.basicGray9)
                        Spacer()
                    }
                }
            )
    }
    
    @ViewBuilder
    private func staticsView(count: Int) -> some View {
        HStack{
            HStack{
                Text("\(count)문장")
                
                Spacer()
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("가나다순")
                }
            }
            .foregroundColor(.primaryOrangeDark)
            .pretendardFont(family: .Medium, size: 14)
            .onTapGesture {
                if archiveViewViewModel.isAscendingOrder {
                    viewModel.bookmarkCards.sort { $0.title < $1.title }
                } else {
                    viewModel.bookmarkCards.sort { $0.title > $1.title }
                }
                archiveViewViewModel.isAscendingOrder.toggle()
            }
        }
        .frame(width: UIScreen.screenWidth - 40, height: 38)
    }
}
