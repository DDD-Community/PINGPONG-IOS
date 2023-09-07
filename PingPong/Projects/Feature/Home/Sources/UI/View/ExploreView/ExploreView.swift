//
//  ExploreView.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct ExploreView: View {
    // 셀에 표시할 데이터 배열
    @StateObject private var viewModel: HomeViewViewModel
    
    public init(viewModel: HomeViewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @EnvironmentObject var sheetManager: SheetManager
    
    let columns = [
        GridItem(.fixed(165)),   GridItem(.fixed(165))
    ]
    
    let buttonHeight: CGFloat = 30
    
    public var body: some View {
        VStack{
            VStack {
                HStack {
                    HStack {
                        ForEach(viewModel.searchViewButtonInfoArray.indices, id: \.self) { idx in
                            Button(action: {
                                withAnimation {
                                    sheetManager.present(with: .init(idx: idx))
                                }
                                sheetManager.isPopup = true
                            }) {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(.primaryOrangeBright)
                                    .frame(width: 64, height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.hotIconBG, lineWidth: 1)
                                            .overlay(
                                                Text("\(viewModel.searchViewButtonInfoArray[idx].title.rawValue)")
                                                    .foregroundColor(.cardTextMain)
                                                    .pretendardFont(family: .SemiBold, size: 14)
                                            )
                                    )
                            }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.25)
            ScrollView(.vertical) {
                let group = filterHomePostContents()
                if group.count != 0 {
                    LazyVGrid(columns: columns) {
                        ForEach(group) { item in
                            let colorSet = searchCharacterColor(flavor: Flavor(rawValue: item.hashtags.flavor.rawValue) ?? .light)
                            VStack {
                                HStack {
                                    let imageSet = viewModel.generateImageNameAndText(hashtags: item.hashtags)
                                    Circle()
                                        .foregroundColor(colorSet.iconBackground)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Image(assetName: imageSet.0)
                                                .resizable()
                                                .frame(width: 14, height: 14)
                                        )
                                    Circle()
                                        .foregroundColor(colorSet.iconBackground)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Image(assetName: imageSet.1)
                                                .resizable()
                                                .frame(width: 14, height: 14)
                                        )
                                    Spacer()
                                }
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 0))
                                Spacer()
                                HStack {
                                    Text(item.title)
                                        .baeEun(size: 18)
                                        .foregroundColor(.cardTextMain)
                                        .allowsTightening(true)
                                        .padding()
                                    Spacer()
                                }
                                HStack {
                                    Text(item.sources)
                                        .baeEun(size: 18)
                                        .foregroundColor(.cardTextMain)
                                        .padding()
                                    Spacer()
                                }
                            }.frame(width: 165, height: 240, alignment: .leading)
                                .background(colorSet.background)
                                .allowsTightening(true)
                                .cornerRadius(10)
                                .onTapGesture {
                                    withAnimation {
                                        sheetManager.isPopup.toggle()
                                    }
                                }
                        }
                    }
                } else {
                    VStack {
                        Image(assetName: "exploreEmptyImage")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("상황에 맞는 명언을 굽지 못했어요.")
                        Text("키워드를 변경해볼까요?")
                    }
                    .pretendardFont(family: .SemiBold, size: 18)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.6)
            Spacer()
        }
    }
    func filterHomePostContents() -> [Post] {
        var filterContent: [Post] = []
        for post in viewModel.homePosts {
            for searchViewButtonInfo in viewModel.searchViewButtonInfoArray {
                for option in searchViewButtonInfo.options{
                    if Flavor(rawValue: option.val) == post.hashtags.flavor && option.isCheck {
                        filterContent.append(post)
                    }
                }
            }
        }
        return filterContent
    }
}


struct SearchOption: Hashable, Identifiable {
    let id: UUID = UUID()
    var val: String
    var detail: String
    var isCheck: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(detail)
        hasher.combine(val)
    }
    
    static func == (lhs: SearchOption, rhs: SearchOption) -> Bool {
        return lhs.detail == rhs.detail && lhs.val == rhs.val
    }
}


struct SearchViewButtonInfo: Identifiable {
    var shouldShowDropdown = false
    let id: UUID = UUID()
    let title: SituationFlavorSourceTitle
    var options: [SearchOption]
    var onSelect: ((_ key: String) -> Void)?
}


