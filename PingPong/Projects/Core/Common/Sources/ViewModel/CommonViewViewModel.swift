//
//  CommonViewViewModel.swift
//  Common
//
//  Created by Byeon jinha on 2023/10/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import SwiftUI
import Model
import Combine
import API
import CombineMoya
import Moya
import Service

public class CommonViewViewModel: ObservableObject {
    
    public init() {
        isFirstUserPOPUP = UserDefaults.standard.bool(forKey: "isFirstUserPOPUP")

    }
    @AppStorage("isFirstUserPOPUP") public var isFirstUserPOPUP: Bool = false

    @Published public var selectedTab: Tab = .home
    @Published public var customTabs: [CustomTab] = []
    
    
    //MARK: 모달 관련
    @Published public var offsetY: CGFloat = 0
    public func generateIsButtonAble(situationFlavorSourceTitle: SearchType) -> Bool {
        
        let situationFlavorSourceArray = searchViewButtonInfoArray.filter{ $0.title.rawValue == situationFlavorSourceTitle.rawValue }
        let count = situationFlavorSourceArray.filter { $0.options[0].isCheck }.count
        //        let totalCount = situationFlavorSourceArray[0].options.count
        return count > 0
    }
    
//    @Published public var selectedCard: CardInfomation?
    
    
    @Published public var isShowDetailView:Bool = false
    
    //MARK: HomeBakeing 관련
    @Published public var exploreViewSearchBarText: String = ""

    
    @Published public var choicedBread: Bread?
    @Published public var choicedIngredent: Ingredent?
    @Published public var choicedTopping: Topping?
    
    
    @Published public var selectSource: Source?
    @Published public var selectFlavor: Flavor?
    @Published public var selectMood: Mood?
    
    @Published public var tmpChoicedBread: Bread?
    @Published public var tmpChoicedIngredent: Ingredent?
    @Published public var tmpChoicedTopping: Topping?
    
    
    @Published public var cards: [CardInfomation] = [] {
        didSet {
            print("card count: \(cards.count)")
            isOn  = Array(repeating: false, count: cards.count)
        }
    }
    @Published public var isOn: [Bool] = []
    
    
    @Published public var searchViewButtonInfoArray: [SearchViewButtonInfo] = [
        SearchViewButtonInfo(title: .situation, options:  [
            SearchOption(val: "동기부여", iconImageName: "", detail: "도전정신과 의지를 북돋아줄 명언"),
            SearchOption(val: "위로", iconImageName: "", detail: "지친 일상을 따스하게 응원해줄 명언"),
            SearchOption(val: "지혜", iconImageName: "", detail: "현명한 인생을 위한 교훈을 주는 명언")]),
        
        SearchViewButtonInfo(title: .flavor, options:  [
            SearchOption(val: "달콤한 맛", iconImageName: "", detail: "지친 삶의 위로, 기쁨을 주는 명언"),
            SearchOption(val: "짭짤한 맛", iconImageName: "", detail: "울컥하게 만드는 감동적인 명언"),
            SearchOption(val: "매콤한 맛", iconImageName: "", detail: "따끔한 조언의 자극적인 명언"),
            SearchOption(val: "고소한 맛", iconImageName: "", detail: "재치있고 유희적인 명언"),
            SearchOption(val: "담백한 맛", iconImageName: "", detail: "지친 삶의 위로, 기쁨을 주는 명언")
        ]),
        
        SearchViewButtonInfo(title: .source, options:  [
            SearchOption(val: "위인", iconImageName: "", detail: "시간이 흘러도 바래지 않는 묵직한 명언"),
            SearchOption(val: "유명인", iconImageName: "", detail: "영향력있는 인물들의 인상적인 명언"),
            SearchOption(val: "드라마/영화", iconImageName: "", detail: "감성을 자극하는 감수성 풍부한 명언"),
            SearchOption(val: "애니메이션", iconImageName: "", detail: "순수함과 동심을 살려주는 따스한 명언"),
            SearchOption(val: "책", iconImageName: "", detail: "정신적 성장을 도와주는 현명한 명언")
        ]),
    ]
    
    func searchCheckCount(idx: Int) -> Int {
        return searchViewButtonInfoArray[idx].options.filter { $0.isCheck }.count
    }
    
//    func filterPostsByText() {
//        if exploreViewSearchBarText.isEmpty {
//            homePosts = originHomePosts
//        } else {
//            homePosts = originHomePosts.filter { $0.title.contains(exploreViewSearchBarText)
//            }
//        }
//    }
    
    public func searchPostIndex(cardInfomation: CardInfomation) -> Int {
        for index in cards.indices {
            if cards[index] == cardInfomation {
                return index
            }
        }
        return 0
    }
    
    public func generateCardByCondition() -> CardInfomation {
        let filteredPosts: [CardInfomation] = cards
            .filter{ choicedBread == nil || $0.hashtags.source.type.bread == choicedBread }
            .filter{ choicedIngredent == nil || $0.hashtags.flavor.type.ingredent == choicedIngredent }
            .filter{ choicedTopping == nil || $0.hashtags.mood.type.topping == choicedTopping}
        guard let ramdomIndex = (0..<filteredPosts.count).randomElement() else { return cards[0] }
        
        return filteredPosts[ramdomIndex]
    }
    
    
    public func createColorSet(flavor: Flavor) -> FlavorColor {
        switch flavor {
        case .sweet: return FlavorColor(icon: .sweetIconText,
                                        iconBackground: .sweetIconBG,
                                        background: .sweetBG)
        case .light: return FlavorColor(icon: .mildIconText,
                                        iconBackground: .mildIconBG,
                                        background: .mildBG)
        case .nutty: return  FlavorColor(icon: .nuttyIconText,
                                         iconBackground: .nuttyIconBG,
                                         background: .nuttyBG)
        case .salty: return  FlavorColor(icon: .saltyIconText,
                                         iconBackground: .saltyIconBG,
                                         background: .saltyBG)
        case .spicy: return FlavorColor(icon: .hotIconText,
                                        iconBackground: .hotIconBG,
                                        background: .hotBG)
        }
    }
}
