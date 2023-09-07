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
  
    //MARK: 모달 관련
    @Published var offsetY: CGFloat = 0
    func generateIsButtonAble(situationFlavorSourceTitle: SituationFlavorSourceTitle) -> Bool {
        
        let situationFlavorSourceArray = searchViewButtonInfoArray.filter{ $0.title == situationFlavorSourceTitle }
        let count = situationFlavorSourceArray.filter { $0.options[0].isCheck }.count
//        let totalCount = situationFlavorSourceArray[0].options.count
        return count > 0
    }
    
    //MARK: HomeBakeing 관련
    @Published var randomInt = (1...2).randomElement()!
    
    @Published var isStartBake: Bool = false
    @Published var isChoicedBread: Bool = false
    @Published var isChoicedIngredent: Bool = false
    @Published var isChoicedTopping: Bool = false
    @Published var isCompleteBake: Bool = false
    
    @Published var choicedBread: Bread?
    @Published var choicedIngredent: Ingredent?
    @Published var choicedTopping: Topping?
    
    @Published var tmpChoicedBread: Bread?
    @Published var tmpChoicedIngredent: Ingredent?
    @Published var tmpChoicedTopping: Topping?
    
    @Published var homePosts = [
        Post(stageNum: 0, hashtags: Hashtags(flavor: .nutty, genre: .drama, situation: .condolence), image: "safari.fill", title: "절대로 멈출수가 없는것들이 있다. 인간이 '자유'의 답을 찾는 한, 그것들은 절대로 멈추지 않는다. 이건 나는 게 아니야 멋지게 추락하는 거지", sources: "<토이스토리, 1955>", isBookrmark: false),
        Post(stageNum: 1, hashtags: Hashtags(flavor: .sweet, genre: .famous, situation: .motive), image: "safari.fill", title: "아 대충살고 싶다.", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 2, hashtags: Hashtags(flavor:.salty, genre: .book, situation: .wisdom), image: "safari.fill", title: "왜 옆자리 아저씨는 도서관까지 와서 카드게임을 하는 걸까?", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 3, hashtags: Hashtags(flavor: .spicy, genre: .greatMan, situation: .condolence), image: "safari.fill", title: "오늘 저녁은 계란을 구워먹겠습니다.", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 0, hashtags: Hashtags(flavor: .nutty, genre: .drama, situation: .motive), image: "safari.fill", title: "이건 나는 게 아니야 멋지게 추락하는 거지", sources: "<토이스토리, 1955>", isBookrmark: false),
        Post(stageNum: 1, hashtags: Hashtags(flavor: .sweet, genre: .famous, situation: .wisdom), image: "safari.fill", title: "아 대충살고 싶다.", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 2, hashtags: Hashtags(flavor:.salty, genre: .book, situation: .condolence), image: "safari.fill", title: "왜 옆자리 아저씨는 도서관까지 와서 카드게임을 하는 걸까?", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 3, hashtags: Hashtags(flavor: .spicy, genre: .greatMan, situation: .motive), image: "safari.fill", title: "오늘 저녁은 계란을 구워먹겠습니다.", sources: "<변진하, 2023>", isBookrmark: false),
        Post(stageNum: 3, hashtags: Hashtags(flavor: .light, genre: .greatMan, situation: .wisdom), image: "safari.fill", title: "담백한 맛 명언.", sources: "<변진하, 2023>", isBookrmark: false),
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
        SearchViewButtonInfo(title: .situation, options:  [
            SearchOption(val: "동기부여", detail: "도전정신과 의지를 북돋아줄 명언"),
            SearchOption(val: "위로", detail: "지친 일상을 따스하게 응원해줄 명언"),
            SearchOption(val: "지혜", detail: "현명한 인생을 위한 교훈을 주는 명언")]),
        
        SearchViewButtonInfo(title: .flavor, options:  [
            SearchOption(val: "달콤한 맛", detail: "지친 삶의 위로, 기쁨을 주는 명언"),
            SearchOption(val: "짭짤한 맛", detail: "울컥하게 만드는 감동적인 명언"),
            SearchOption(val: "매콤한 맛", detail: "따끔한 조언의 자극적인 명언"),
            SearchOption(val: "고소한 맛", detail: "재치있고 유희적인 명언"),
            SearchOption(val: "담백한 맛", detail: "지친 삶의 위로, 기쁨을 주는 명언")
        ]),
        
        SearchViewButtonInfo(title: .source, options:  [
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
        let arhiveView = ArchiveView(viewModel: self)
        let customTabHome = CustomTab(name: "홈", imageName: "house.fill", tab: .home, view: AnyView(homeView), isOn: false)
        let customTabSafari = CustomTab(name: "탐색", imageName: "plus.magnifyingglass", tab: .explore, view: AnyView(exploreView), isOn: false)
        let customTabArchive = CustomTab(name: "보관함", imageName: "archivebox", tab: .archive, view: AnyView(arhiveView), isOn: false)

        customTabs = [customTabHome, customTabSafari, customTabArchive]
    }
    
    func generateImageNameAndText(hashtags: Hashtags) -> (String, String, String, String) {
        var flavorAndGenre: (String, String, String, String) = ("", "", "", "")

        switch hashtags.flavor {
        case .light:
            flavorAndGenre.0 = "lightImage"
            flavorAndGenre.2 = "CardBG_Mild_\(randomInt)"
        case .spicy:
            flavorAndGenre.0 = "spicyImage"
            flavorAndGenre.2 = "CardBG_Hot_\(randomInt)"
        case .sweet:
            flavorAndGenre.0 = "sweetImage"
            flavorAndGenre.2 = "CardBG_Sweet_\(randomInt)"
        case .salty:
            flavorAndGenre.0 = "saltyImage"
            flavorAndGenre.2 = "CardBG_Salty_\(randomInt)"
        case .nutty:
            flavorAndGenre.0 = "nuttyImage"
            flavorAndGenre.2 = "CardBG_nutty_\(randomInt)"
        }
        
        switch hashtags.genre {
        case .animation:
            flavorAndGenre.1 = "animeImage"
        case .book:
            flavorAndGenre.1 = "bookImage"
        case .drama:
            flavorAndGenre.1 = "dramaImage"
        case .famous:
            flavorAndGenre.1 = "celeImage"
        case .greatMan:
            flavorAndGenre.1 = "greatmanImage"
        }
        
        switch hashtags.situation {
        case .condolence:
            flavorAndGenre.3 = "condolenceImage"
        case .motive:
            flavorAndGenre.3 = "motiveImage"
        case .wisdom:
            flavorAndGenre.3 = "wisdomImage"
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
    var imageName: String
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
    case greatMan = "위인"
}

enum Situation: String {
    case condolence = "위로"
    case motive = "동기"
    case wisdom = "지혜"
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
    let situation: Situation
}

enum Bread: String {
    case breadViewBread = "carouselgreatmanImage"
    case croissant = "carouselceleImage"
    case pancake = "carouseldramaImage"
    case cookie = "carouselanimeImage"
    case ciabatta = "carouselbookImage"
}

enum Ingredent: String {
    case chocolate = "carouselsweetImage"
    case cheese = "carouselsaltyImage"
    case jalapeno = "carouselspicyImage"
    case cream = "carouselnuttyImage"
    case corn = "carousellightImage"
}

enum Topping: String {
    case appleJam = "carouselcondolenceImage"
    case caramelSyrup = "carouselmotiveImage"
    case chestnut = "carouselwisdomImage"
}


enum SituationFlavorSourceTitle: String {
    case situation = "상황"
    case flavor = "맛"
    case source = "출처"
}
