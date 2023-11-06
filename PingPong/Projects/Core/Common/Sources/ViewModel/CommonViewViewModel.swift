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
    @Published public var offsetY: CGFloat = 30
    public func generateIsButtonAble(situationFlavorSourceTitle: SearchType) -> Bool {
        
        let situationFlavorSourceArray = searchViewButtonInfoArray.filter{ $0.title.rawValue == situationFlavorSourceTitle.rawValue }
        let count = situationFlavorSourceArray.filter { $0.options[0].isCheck }.count
        //        let totalCount = situationFlavorSourceArray[0].options.count
        return count > 0
    }
    
    @Published public var selectedCard: CardInfomation = CardInfomation(qouteId: 0, hashtags: Hashtags(flavor: .light, source: .anime, mood: .motivation), image: "", title: "", sources: "", isBookrmark: false)
    
    
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
    
    @Published public var searchedCards: [CardInfomation] = []
    
    @Published public var isOn: [Bool] = []
    
    
    @Published public var searchViewButtonInfoArray: [SearchViewButtonInfo] = [
        SearchViewButtonInfo(title: .situation, options:  [
            SearchOption(korean: "동기부여", english: "motivation", iconImageName: "", detail: "도전정신과 의지를 북돋아줄 명언"),
            SearchOption(korean: "위로", english: "support", iconImageName: "", detail: "지친 일상을 따스하게 응원해줄 명언"),
            SearchOption(korean: "지혜", english: "wisdom", iconImageName: "", detail: "현명한 인생을 위한 교훈을 주는 명언")]),
        
        SearchViewButtonInfo(title: .flavor, options:  [
            SearchOption(korean: "달콤한 맛", english: "sweet", iconImageName: "", detail: "지친 삶의 위로, 기쁨을 주는 명언"),
            SearchOption(korean: "짭짤한 맛", english: "salty", iconImageName: "", detail: "울컥하게 만드는 감동적인 명언"),
            SearchOption(korean: "매콤한 맛", english: "spicy", iconImageName: "", detail: "따끔한 조언의 자극적인 명언"),
            SearchOption(korean: "고소한 맛", english: "nutty", iconImageName: "", detail: "재치있고 유희적인 명언"),
            SearchOption(korean: "담백한 맛", english: "light", iconImageName: "", detail: "지친 삶의 위로, 기쁨을 주는 명언")
        ]),
        
        SearchViewButtonInfo(title: .source, options:  [
            SearchOption(korean: "위인", english: "greatman", iconImageName: "", detail: "시간이 흘러도 바래지 않는 묵직한 명언"),
            SearchOption(korean: "유명인", english: "celeb", iconImageName: "", detail: "영향력있는 인물들의 인상적인 명언"),
            SearchOption(korean: "드라마/영화", english: "film", iconImageName: "", detail: "감성을 자극하는 감수성 풍부한 명언"),
            SearchOption(korean: "애니메이션", english: "animation", iconImageName: "", detail: "순수함과 동심을 살려주는 따스한 명언"),
            SearchOption(korean: "책", english: "book", iconImageName: "", detail: "정신적 성장을 도와주는 현명한 명언")
        ]),
    ]
    
    @Published public var homeBaseModel: BaseModel?
    
    var homeLikeCancellable: AnyCancellable?
    
    @Published public var deleteModel: DeleteModel?
    var deleteLikeCancellbale: AnyCancellable?
    
    public  func generateParameter(searchType: SearchType) -> [String] {
        let searchArray: [SearchOption] = searchViewButtonInfoArray.filter{ $0.title == searchType }[0].options.filter { $0.isCheck }
        let parameterArray: [String] = searchArray.compactMap{ $0.english }
        return parameterArray
    }
    
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
    //MARK: -  홈  좋아요  및  스크램 api
    public func homeBaseToViewModel(_ list: BaseModel) {
        self.homeBaseModel = list
    }

    public func quoteLikeRequest(userID: String, quoteId: Int) async {
        if let cancellable = homeLikeCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
        homeLikeCancellable = provider.requestWithProgressPublisher(.homeLike(userId: userID, quoteId: quoteId))
            .compactMap { $0.response?.data }
            .receive(on: DispatchQueue.main)
            .decode(type: BaseModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.success.status {
                    self?.homeBaseToViewModel(model)
                    print("홈 취향", model)
                } else {
                    self?.homeBaseToViewModel(model)
                    print("홈 취향", model)
                }
            })
    }
    
    public func deleteToViewModel(_ list: DeleteModel){
        self.deleteModel = list
    }
    
    //MARK: -  좋아요 취소
    public func deleteLikeQuote(likeID: Int, completion: @escaping () -> Void) async {
        if let cancellable = deleteLikeCancellbale {
            cancellable.cancel()
        }
        let provider = MoyaProvider<MyPageService>(plugins: [MoyaLoggingPlugin()])
        deleteLikeCancellbale = provider.requestWithProgressPublisher(.deleteLike(likeId: likeID))
            .compactMap { $0.response?.data }
            .receive(on: DispatchQueue.main)
            .decode(type: DeleteModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.success.status {
                    self?.deleteToViewModel(model)
                    print("좋아요 삭제", model)
                } else {
                    self?.deleteToViewModel(model)
                    print("좋아요 삭제", model)
                }
            })
    }
    
    
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
        guard let ramdomIndex = (0..<filteredPosts.count).randomElement() else { return CardInfomation(qouteId: 0, hashtags: Hashtags(flavor: .light, source: .anime, mood: .motivation), image: "", title: "", sources: "", isBookrmark: false) }
        
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
    
    public func getHashtags(post: QuoteContent) -> Hashtags {
        let flavor = Flavor(rawValue: post.flavor ?? "")!
        let source = Source(rawValue: post.source ?? "")!
        let mood = Mood(rawValue: post.mood ?? "")!
        
        return Hashtags(flavor: flavor, source: source, mood: mood)
    }
}
