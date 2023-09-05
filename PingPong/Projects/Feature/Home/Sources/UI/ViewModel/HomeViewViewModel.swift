//
//  HomeViewViewModel.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Model

public class HomeViewViewModel: ObservableObject {
    
    @AppStorage("isFirstUserPOPUP") public var isFirstUserPOPUP: Bool = false
    
    @Published var selectedTab: Tab = .home
    @Published var customTabs: [CustomTab] = []
  
    //MARK: HomeBakeing 관련
    @Published var isStartBake: Bool = false
    @Published var isChoicedBread: Bool = false
    @Published var isChoicedIngredent: Bool = false
    @Published var isChoicedTopping: Bool = false
    @Published var isCompleteBake: Bool = false
    
    @Published var choicedBread: Bread?
    @Published var choicedIngredent: Ingredent?
    @Published var choicedTopping: Topping?
    
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
    enum SituationFlavorSource: String {
        case motivation = "동기부여"
        case consolation = "위로"
        case wisdom = "지혜"
        case sweet = "달콤한 맛"
        case salty = "짭짤한 맛"
        case spicy = "매콤한 맛"
        case nutty = "고소한 맛"
        case light = "담백한 맛"
        case historicalFigures = "위인"
        case celebrities = "유명인"
        case dramaMovies = "드라마/영화"
        case animation = "애니메이션"
        case books = "책"
    }
    @Published var searchViewButtonInfoArray: [SearchViewButtonInfo] = [
        SearchViewButtonInfo(title: "상황", options:  [
            SearchOption(val: "동기부여", detail: "도전정신과 의지를 북돋아줄 명언"),
            SearchOption(val: "위로", detail: "지친 일상을 따스하게 응원해줄 명언"),
            SearchOption(val: "지혜", detail: "현명한 인생을 위한 교훈을 주는 명언")]),
        
        SearchViewButtonInfo(title: "맛", options:  [
            SearchOption(val: "달콤한 맛", detail: "지친 삶의 위로, 기쁨을 주는 명언"),
            SearchOption(val: "짭짤한 맛", detail: "울컥하게 만드는 감동적인 명언"),
            SearchOption(val: "매콤한 맛", detail: "따끔한 조언의 자극적인 명언"),
            SearchOption(val: "고소한 맛", detail: "재치있고 유희적인 명언"),
            SearchOption(val: "담백한 맛", detail: "지친 삶의 위로, 기쁨을 주는 명언")
        ]),
        
        SearchViewButtonInfo(title: "출처", options:  [
            SearchOption(val: "위인", detail: "시간이 흘러도 바래지 않는 묵직한 명언"),
            SearchOption(val: "유명인", detail: "영향력있는 인물들의 인상적인 명언"),
            SearchOption(val: "드라마/영화", detail: "감성을 자극하는 감수성 풍부한 명언"),
            SearchOption(val: "애니메이션", detail: "순수함과 동심을 살려주는 따스한 명언"),
            SearchOption(val: "책", detail: "정신적 성장을 도와주는 현명한 명언")
        ]),
    ]
    
    public init() {
         setupCustomTabs(homePosts: homePosts)
        isFirstUserPOPUP = UserDefaults.standard.bool(forKey: "isFirstUserPOPUP")
                
        
    }

    private func setupCustomTabs(homePosts: [Post]) {
        let homeView = HomeView(viewModel: self)
        let exploreView = ExploreView(viewModel: self)
        let arhiveView = ArchiveView()
        let customTabHome = CustomTab(name: "홈", image: "house.fill", tab: .home, view: AnyView(homeView), isOn: false)
        let customTabSafari = CustomTab(name: "탐색", image: "plus.magnifyingglass", tab: .explore, view: AnyView(exploreView), isOn: false)
        let customTabArchive = CustomTab(name: "보관함", image: "archivebox", tab: .archive, view: AnyView(arhiveView), isOn: false)

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
    case explore
    case archive
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

enum Bread: String {
    case breadViewBread = "breadViewBread"
    case croissant = "croissant"
    case pancake = "pancake"
    case cookie = "cookie"
    case ciabatta = "ciabatta"
}

enum Ingredent: String {
    case chocolate = "chocolate"
    case cheese = "cheese"
    case jalapeno = "jalapeno"
    case cream = "cream"
    case corn = "corn"
}

enum Topping: String {
    case appleJam = "appleJam"
    case caramelSyrup = "caramelSyrup"
    case chestnut = "chestnut"
}
