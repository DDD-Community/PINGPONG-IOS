//
//  HomeViewViewModel.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

public class HomeViewViewModel: ObservableObject {
    
    
    @Published var selectedTab: Tab = .home
    @Published var customTabs: [CustomTab] = []
  
    @Published var homePosts = [
        Post(stageNum: 0, hashtags: Hashtags(flavor: .nutty, genre: .drama), image: "safari.fill", title: "이건 나는 게 아니야 멋지게 추락하는 거지", sources: "<토이스토리, 1955>", isBookrmark: false),
        Post(stageNum: 1, hashtags: Hashtags(flavor: .sweet, genre: .famous), image: "safari.fill", title: "아 대충살고 싶다.", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 2, hashtags: Hashtags(flavor:.salty, genre: .book), image: "safari.fill", title: "왜 옆자리 아저씨는 도서관까지 와서 카드게임을 하는 걸까?", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 3, hashtags: Hashtags(flavor: .spicy, genre: .greatMan), image: "safari.fill", title: "오늘 저녁은 계란을 구워먹겠습니다.", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 0, hashtags: Hashtags(flavor: .nutty, genre: .drama), image: "safari.fill", title: "이건 나는 게 아니야 멋지게 추락하는 거지", sources: "<토이스토리, 1955>", isBookrmark: false),
        Post(stageNum: 1, hashtags: Hashtags(flavor: .sweet, genre: .famous), image: "safari.fill", title: "아 대충살고 싶다.", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 2, hashtags: Hashtags(flavor:.salty, genre: .book), image: "safari.fill", title: "왜 옆자리 아저씨는 도서관까지 와서 카드게임을 하는 걸까?", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 3, hashtags: Hashtags(flavor: .spicy, genre: .greatMan), image: "safari.fill", title: "오늘 저녁은 계란을 구워먹겠습니다.", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 3, hashtags: Hashtags(flavor: .light, genre: .greatMan), image: "safari.fill", title: "담백한 맛 명언.", sources: "<변진하, 2023>", isBookrmark: false),
    ]
    
    
    public init() {
         setupCustomTabs(homePosts: homePosts)
        
    }

    private func setupCustomTabs(homePosts: [Post]) {
        

        let homeView = HomeView(viewModel: self)
        let exploreView = ExploreView(viewModel: self)
        let arhiveView = ArchiveView()
        let customTabHome = CustomTab(name: "홈", image: "house.fill", tab: .home, view: AnyView(homeView), isOn: false)
        let customTabSafari = CustomTab(name: "탐색", image: "plus.magnifyingglass", tab: .safari, view: AnyView(exploreView), isOn: false)
        let customTabArchive = CustomTab(name: "보관함", image: "archivebox", tab: .archivebox, view: AnyView(arhiveView), isOn: false)

        customTabs = [customTabHome, customTabSafari, customTabArchive]
    }
    
    func generateImageNameAndText(hashtags: Hashtags) -> (String, String, String){
        var flavorAndGenre: (String, String, String) = ("","", "")
        switch hashtags.flavor {
        case .light:
            flavorAndGenre.0 = "lightImage"
            flavorAndGenre.2 = "CardBG_Mild_1"
        case .spicy:
            flavorAndGenre.0 = "spicyImage"
            flavorAndGenre.2 = "CardBG_Hot_1"
        case .sweet:
            flavorAndGenre.0 = "sweetImage"
            flavorAndGenre.2 = "CardBG_Sweet_1"
        case .salty:
            flavorAndGenre.0 = "saltyImage"
            flavorAndGenre.2 = "CardBG_Salty_1"
        case .nutty:
            flavorAndGenre.0 = "nuttyImage"
            flavorAndGenre.2 = "CardBG_nutty_1"
        }
        
        switch hashtags.genre {
        case .animation:
            flavorAndGenre.1 = "animeImage"
        case .book:
            flavorAndGenre.1 = "bookImage"
        case .drama:
            flavorAndGenre.1 = "dramaImage"
        case .etc:
            flavorAndGenre.1 = ""
        case .famous:
            flavorAndGenre.1 = "celeImage"
        case .greatMan:
            flavorAndGenre.1 = "greatmanImage"
        }

        return flavorAndGenre
    }
}

enum Tab {
    case home
    case safari
    case archivebox
}

struct CustomTab {
    var name: String
    var image: String
    var tab: Tab
    var view: AnyView
    var isOn: Bool
}

enum Flavor: String {
    case sweet = "달콤한 맛"
    case salty = "짭짤한 맛"
    case spicy = "매콤한 맛"
    case nutty = "고소한 맛"
    case light = "담백한 맛"
}

enum Genre: String {
    case animation = "애니메이션"
    case famous = "유명인"
    case book = "책"
    case drama = "드라마"
    case etc = "기타"
    case greatMan = "위인"
}

struct Post: Identifiable, Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.title == rhs.title
    }
    
    var id = UUID().uuidString
    var stageNum : Int
    var hashtags: Hashtags
    var image: String
    var title: String
    var sources: String
    var isBookrmark: Bool
}

struct Hashtags {
    let flavor: Flavor
    let genre: Genre
}
