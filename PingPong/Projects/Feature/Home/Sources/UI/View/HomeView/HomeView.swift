
//
//  HomeView.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import SwiftUI
import Model

public struct HomeView: View {
    
    @State var currentIndex: Int = 0
    @StateObject private var viewModel: HomeViewViewModel
    @StateObject var appState: HomeAppState = HomeAppState()

    @State var isOn: [Bool] = []
    public init(viewModel: HomeViewViewModel) {
        self._isOn = State(initialValue: Array(repeating: false, count: viewModel.homePosts.count))
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        
        ZStack{
            VStack{
                SnapCarousel(index: $currentIndex, items: viewModel.homePosts, isOn : $isOn ){ post in
                    let imageNameAndText = self.viewModel.generateImageNameAndText(hashtags: post.hashtags)
                    GeometryReader{ proxy in
                        let size = proxy.size
                        let colorSet = searchCharacterColor(flavor: post.hashtags.flavor)
                        
                        let shareView =
                        VStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(colorSet.background)
                                .frame(width: size.width, height: size.height * 0.6)
                                .overlay(
                                    ZStack {
                                        VStack {
                                            HStack {
                                                Image(assetName: imageNameAndText.2)
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
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
                                                        Text(post.title)
                                                            .baeEun(size: 28)
                                                            .foregroundColor(.cardTextMain)
                                                            .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                                        Spacer()
                                                    }
                                                    Text(post.sources)
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
                        } .frame(width: size.width, height: size.height * 0.8)
                            
                        
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: size.width, height: size.height * 0.62)
                            .foregroundColor(colorSet.background)
                            .opacity(isOn[post.stageNum] ? 1 : 0.3)
                            .overlay(
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image(assetName: imageNameAndText.2)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    VStack{
                                        HStack{
                                            HStack{
                                                RoundedRectangle(cornerRadius: 16)
                                                    .frame(width: 86, height: 26)
                                                    .foregroundColor(.basicGray1BG)
                                                    .overlay(
                                                        HStack {
                                                            Image(assetName: imageNameAndText.0)
                                                            Text("\(post.hashtags.flavor.rawValue)")
                                                                .pretendardFont(family: .SemiBold, size: 12)
                                                                .foregroundColor(colorSet.icon)
                                                        }
                                                    )
                                                
                                                RoundedRectangle(cornerRadius: 16)
                                                    .frame(width: 86, height: 26)
                                                    .foregroundColor(.basicGray1BG)
                                                    .overlay(
                                                        
                                                        HStack {
                                                            Image(assetName: imageNameAndText.1)
                                                            Text("\(post.hashtags.genre.rawValue)")
                                                                .pretendardFont(family: .SemiBold, size: 12)
                                                                .foregroundColor(colorSet.icon)
                                                        }
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
                                                    Text(post.title)
                                                        .baeEun(size: 28)
                                                        .foregroundColor(.cardTextMain)
                                                        .padding(EdgeInsets(top: 0, leading: 19, bottom: 31, trailing:0))
                                                    Spacer()
                                                }
                                                Text(post.sources)
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
                                                        shareContent(content: shareView.asImage())
                                                    }
                                                Circle()
                                                    .frame(width: 44)
                                                    .overlay(
                                                        Image(systemName: "heart")
                                                            .foregroundColor(post.isBookrmark ?  .basicWhite : colorSet.icon)
                                                    )
                                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 16))
                                                    .foregroundColor(post.isBookrmark ? colorSet.icon : colorSet.iconBackground)
                                                    .onTapGesture {
                                                        let postIndex = searchPostIndex(post: post)
                                                        viewModel.homePosts[postIndex].isBookrmark.toggle()
                                                    }
                                            }
                                        }
                                    }
                                }
                            )
                    }
                }.frame(height: UIScreen.screenHeight * 0.64)
                
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
            .onAppear {
                if !isOn.isEmpty { //빈배열일 경우 방어문
                    self.isOn[0] = true
                }
            }
            .navigationDestination(isPresented: $appState.goToBackingView) {
                HomeBakeingView(viewModel: viewModel, backAction: {
                    appState.goToBackingView = false
                })
            }
        }
    }
    func searchPostIndex(post: Post) -> Int {
        for index in viewModel.homePosts.indices {
            if viewModel.homePosts[index] == post {
                return index
            }
        }
        return 0
    }
}

func searchCharacterColor(flavor: Flavor) -> CharacterColor {
    switch flavor {
    case .sweet: return CharacterColor(icon: .sweetIconText,
                                       iconBackground: .sweetIconBG,
                                       background: .sweetBG)
    case .light: return CharacterColor(icon: .mildIconText,
                                       iconBackground: .mildIconBG,
                                       background: .mildBG)
    case .nutty: return  CharacterColor(icon: .nuttyIconText,
                                        iconBackground: .nuttyIconBG,
                                        background: .nuttyBG)
    case .salty: return  CharacterColor(icon: .saltyIconText,
                                        iconBackground: .saltyIconBG,
                                        background: .saltyBG)
    case .spicy: return CharacterColor(icon: .hotIconText,
                                       iconBackground: .hotIconBG,
                                       background: .hotBG)
    }
}

func shareContent(content: UIImage) {
    let avc = UIActivityViewController(activityItems: [content], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
}

extension View {
    func asImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        view?.bounds = CGRect(origin: .zero, size: size)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}

