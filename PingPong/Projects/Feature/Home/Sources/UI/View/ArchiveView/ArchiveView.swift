//
//  ArchiveView.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct ArchiveView: View {
    @StateObject private var viewModel: HomeViewViewModel
    @StateObject var appState: HomeAppState = HomeAppState()
    
    public init(viewModel: HomeViewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @EnvironmentObject var sheetManager: SheetManager
    
    let columns = [
        GridItem(.fixed(165)),   GridItem(.fixed(165))
    ]
    
    let buttonHeight: CGFloat = 30
    
    public var body: some View {
        VStack(){
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
            let group = generateBookmarkPostContents()
            if group.count != 0 {
                ScrollView(.vertical) {
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
                                .cornerRadius(10)
                                .onTapGesture {
                                    withAnimation {
                                        sheetManager.isPopup.toggle()
                                    }
                                }
                        }
                    }
                }
            } else {
                VStack(alignment: .center){
                    Spacer()
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
            }
        }
        .navigationDestination(isPresented: $appState.goToBackingView) {
            HomeBakingView(viewModel: viewModel, backAction: {
                appState.goToBackingView = false
            })
        }
    }
    func generateBookmarkPostContents() -> [Post] {
        var filterContent: [Post] = []
        for post in viewModel.homePosts {
            if post.isBookrmark {
                filterContent.append(post)
            }
        }
        return filterContent
    }
}
