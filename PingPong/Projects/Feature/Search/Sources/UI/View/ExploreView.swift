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
                
                VStack {
                    HStack {
                        HStack {
                            
                            ForEach(viewModel.searchViewButtonInfoArray.indices, id: \.self) { idx in
                                
                                //TODO: 버튼 정보 예: 맛 + 3 이런 식으로 처리하기
//                                let info: OptionButtonInfo =  viewModel.generateInfo(
//                                    situationFlavorSourceTitle: .situation,
//                                    flavorCountInfo: .init(title: "0", count: idx),
//                                    situationInfo: .init(title: "0", count: idx),
//                                    sourceCountInfo: .init(title: "0", count: idx))
                                Button(action: {
                                    withAnimation {
                                        sheetManager.present(with: .init(idx: idx))
                                    }
                                    sheetManager.isPopup = true
                                }) {
                                    
//                                    Text(info.count == 0 ? "\(viewModel.searchViewButtonInfoArray[idx].title.rawValue)" : "\(info.title) +\(info.count)")
//                                        .foregroundColor(.cardTextMain)
//                                        .pretendardFont(family: .SemiBold, size: 14)
//                                        .frame(minWidth: 48, minHeight: 30)
//                                        .padding(.horizontal, 8)
//                                        .background(
//                                            RoundedRectangle(cornerRadius: 8)
//                                                .foregroundColor(info.count == 0 ? .primaryOrangeBright: .primaryOrangeOpacity40)
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 10)
//                                                        .stroke(info.count == 0 ? Color.hotIconBG : .primaryOrange, lineWidth: 1)
//                                                )
//                                        )
                                }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        
                        Spacer()
                    }
                }
                .frame(height:46)
                
                staticsView(count: viewModel.cards.count)
                
                if !viewModel.cards.isEmpty {
//                    searchTextisEmptyQuote
                    
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
    }
    
//    func generateSituationFlavorSourceArray(situationFlavorSourceTitle: SituationFlavorSourceTitle) -> ([String], OptionButtonInfo) {
//        var situationFlavorSourceCount: Int = 0
//        var isFirst: Bool = true
//        var situationFlavorSource: String = ""
//        var situationFlavorSourceArray:[String] = []
////        for searchViewButtonInfo in viewModel.searchViewButtonInfoArray where searchViewButtonInfo.title == situationFlavorSourceTitle {
////            if searchViewButtonInfo.options.filter({ $0.isCheck }).count == 0 {
////                for option in searchViewButtonInfo.options{
////                    situationFlavorSourceArray.append(option.val)
////                }
////            } else {
////                for index in searchViewButtonInfo.options.indices {
////                    let option = searchViewButtonInfo.options[index]
////                    if option.isCheck {
////                        if isFirst {
////                            situationFlavorSource = option.val
////                            isFirst = false
////                        }
////                        situationFlavorSourceArray.append(option.val)
////                        situationFlavorSourceCount += 1
////                    }
////                }
////            }
////        }
//        return (situationFlavorSourceArray, OptionButtonInfo(title: situationFlavorSource, count: situationFlavorSourceCount))
//    }
    
//    func filterHomePostContents() -> ([Post], OptionButtonInfo, OptionButtonInfo, OptionButtonInfo) {
//        var filterContent: [Post] = []
//
//        let (situationArray, situationInfo):([String], OptionButtonInfo) = generateSituationFlavorSourceArray(situationFlavorSourceTitle: .situation)
//        let (flavorArray, flavorInfo):([String], OptionButtonInfo) = generateSituationFlavorSourceArray(situationFlavorSourceTitle: .flavor)
//        let (sourceArray, sourceInfo):([String], OptionButtonInfo) = generateSituationFlavorSourceArray(situationFlavorSourceTitle: .source)
//
////        for post in viewModel.homePosts {
////            if flavorArray.contains(post.hashtags.flavor.rawValue) &&
////                situationArray.contains(post.hashtags.situation.rawValue) &&
////                sourceArray.contains(post.hashtags.source.rawValue) {
////                filterContent.append(post)
////            }
////        }
//
//        return (filterContent, situationInfo, flavorInfo, sourceInfo)
//    }
    
    
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
    
//    private var searchTextisEmptyQuote: some View {
//        ScrollView(.vertical) {
//            LazyVGrid(columns: columns) {
//                ForEach(viewModel.cards) { item in
//                    let colorSet = viewModel.createColorSet(flavor: item.hashtags.flavor)
//                    VStack {
//                        HStack {
//                            let imageSet = viewModel.generateImageNameAndText(hashtags: item.hashtags)
//                            Circle()
//                                .foregroundColor(colorSet.iconBackground)
//                                .frame(width: 20, height: 20)
//                                .overlay(
//                                    Image(assetName: imageSet.userCustomFlavorImageName)
//                                        .resizable()
//                                        .frame(width: 14, height: 14)
//                                )
//                            Circle()
//                                .foregroundColor(colorSet.iconBackground)
//                                .frame(width: 20, height: 20)
//                                .overlay(
//                                    Image(assetName: imageSet.userCustomSourceIconImageName)
//                                        .resizable()
//                                        .frame(width: 14, height: 14)
//                                )
//                            Spacer()
//                        }
//                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 0))
//
//                        Spacer()
//
//                        HStack {
//                            Text(item.title)
//                                .baeEun(size: 18)
//                                .foregroundColor(.cardTextMain)
//                                .allowsTightening(true)
//                                .padding()
//                            Spacer()
//                        }
//
//                        HStack {
//                            Text(item.author)
//                                .baeEun(size: 18)
//                                .foregroundColor(.cardTextMain)
//                                .padding()
//                            Spacer()
//                        }
//                    }
//                        .frame(width: 175, height: 240, alignment: .leading)
//                        .background(colorSet.background)
//                        .allowsTightening(true)
//                        .cornerRadius(10)
//                        .onTapGesture {
//                            withAnimation {
//                                let imageNameAndText = self.viewModel.generateImageNameAndText(hashtags: item.hashtags)
//                                viewModel.updateDetailViewInfo(colorSet: colorSet, cardInfomation: item, imageNameAndText: imageNameAndText)
//                                viewModel.isShowDetailView.toggle()
//                            }
//                        }
//                }
//            }
//        }
//        .frame(height: UIScreen.main.bounds.height * 0.6)
//    }
    
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
                    viewModel.cards.sort { $0.title < $1.title }
                } else {
                    viewModel.cards.sort { $0.title > $1.title }
                }
                archiveViewViewModel.isAscendingOrder.toggle()
            }
        }
        .frame(width: UIScreen.screenWidth - 40, height: 38)
    }
}


