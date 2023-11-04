//
//  ExploreView.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import Model
import SwiftUI
import Model
import Common
import Archive


public struct ExploreView: View {
    // 셀에 표시할 데이터 배열
    @StateObject private var viewModel: CommonViewViewModel
    @StateObject var archiveViewViewModel: ArchiveViewViewModel = ArchiveViewViewModel()
    @StateObject var exploreViewViewModel: ExploreViewModel = ExploreViewModel()
    
    public init(viewModel: CommonViewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @EnvironmentObject var sheetManager: SheetManager
    
    let columns = [
        GridItem(.fixed(175)),   GridItem(.fixed(175))
    ]
    
    let buttonHeight: CGFloat = 30
    
    public var body: some View {
        ZStack {
            ScrollView(.vertical){
                //                let (group, situationInfo, flavorCountInfo, sourceCountInfo) = filterHomePostContents()
                
                searchBar()
                    .padding(.top, 62)
                
                searchHashTagView()
                
                staticsView(count: viewModel.searchedCards.count)
                
                if !viewModel.searchedCards.isEmpty {
                    searchTextisEmptyQuote
                    
                }  else {
                    
                    VStack {
                        Image(assetName: "exploreEmptyImage")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("상황에 맞는 명언을 굽지 못했어요.")
                        Text("키워드를 변경해볼까요?")
                            .pretendardFont(family: .SemiBold, size: 18)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.6)
                }
                
            }
        }
        .task {
            await exploreViewViewModel.searchRequest(keyword: viewModel.exploreViewSearchBarText, flavors: [], sources: [], mood: [], orderBy: "") {
                viewModel.searchedCards = []
                for quoteContent in exploreViewViewModel.searchModel?.data?.content ?? [] {
                    let hashTags = viewModel.getHashtags(post: quoteContent)
                    self.viewModel.likeYn = quoteContent.likeYn ?? false
                    let card = CardInfomation(qouteId: quoteContent.quoteID ?? .zero,
                                              hashtags: hashTags, image: "",
                                              title: quoteContent.content ?? "",
                                              sources: quoteContent.author ?? "",
                                              isBookrmark: quoteContent.likeYn ?? false)
                    viewModel.searchedCards.append(card)
                }
            }
        }
        
        .onChange(of: viewModel.exploreViewSearchBarText, perform: { value in
            Task {
                await exploreViewViewModel.searchRequest(keyword: value, flavors: [], sources: [], mood: [], orderBy: "") {
                    viewModel.searchedCards = []
                    for quoteContent in exploreViewViewModel.searchModel?.data?.content ?? [] {
                        let hashTags = viewModel.getHashtags(post: quoteContent)
                        self.viewModel.likeYn = quoteContent.likeYn ?? false
                        let card = CardInfomation(qouteId: quoteContent.quoteID ?? .zero,
                                                  hashtags: hashTags, image: "",
                                                  title: quoteContent.content ?? "",
                                                  sources: quoteContent.author ?? "",
                                                  isBookrmark: quoteContent.likeYn ?? false)
                        viewModel.searchedCards.append(card)
                    }
                }
            }
        })
        
    }
    
    
    @ViewBuilder
    private func searchBar() -> some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.primaryOrangeBright)
            .frame(width: UIScreen.screenWidth - 40, height: 48)
            .overlay(
                HStack{
                    TextField("", text: $viewModel.exploreViewSearchBarText)
                        .pretendardFont(family: .SemiBold, size: 18)
                        .padding(.leading, 15)
                    
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 17, height: 17)
                        .padding(15)
                        .onTapGesture {
                            //                            viewModel.filterPostsByText()
                        }
                }
            )
    }
    
    private var searchTextisEmptyQuote: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.searchedCards) { card in
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
    }
    
    @ViewBuilder
    private func searchHashTagView() -> some View {
        VStack {
            HStack {
                HStack {
                    
                    ForEach(viewModel.searchViewButtonInfoArray.indices, id: \.self) { idx in
                        
                        //                                TODO: 버튼 정보 예: 맛 + 3 이런 식으로 처리하기
                        //                                let info: OptionButtonInfo = exploreViewViewModel.optionButtonInfoArray[idx]
                        let info = viewModel.searchViewButtonInfoArray[idx]
                        
                        Button(action: {
                            withAnimation {
                                sheetManager.present(with: .init(idx: idx))
                            }
                            sheetManager.isPopup = true
                        }) {
                            
                            Text(info.count == 0 ? "\(viewModel.searchViewButtonInfoArray[idx].title.rawValue)" : "\(info.choicedTitle)")
                                .foregroundColor(.cardTextMain)
                                .pretendardFont(family: .SemiBold, size: 14)
                                .frame(minWidth: 48, minHeight: 30)
                                .padding(.horizontal, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(info.count == 0 ? .primaryOrangeBright: .primaryOrangeOpacity40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(info.count == 0 ? Color.hotIconBG : .primaryOrange, lineWidth: 1)
                                        )
                                )
                        }
                    }
                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                
                Spacer()
            }
        }
        .frame(height:46)
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
                    viewModel.searchedCards.sort { $0.title < $1.title }
                } else {
                    viewModel.searchedCards.sort { $0.title > $1.title }
                }
                archiveViewViewModel.isAscendingOrder.toggle()
            }
        }
        .frame(width: UIScreen.screenWidth - 40, height: 38)
    }
}


