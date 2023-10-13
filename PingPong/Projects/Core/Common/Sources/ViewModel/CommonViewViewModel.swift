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
//        setupCustomTabs(homePosts: homePosts)
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
    
   
    
    //MARK: -  랜덤  명언 조회 api
    @Published public var homeRandomQuoteModel: HomeRandomQuoteModel?
    public var homeRandomQuoteCancellable: AnyCancellable?
    
    @Published public var homeUserPrefModel: UserPrefModel?
    public var homeUserPrefCancellable: AnyCancellable?
    
    @Published public var homeLikeScrapModel: BaseModel?
    var homeLikeCancellable: AnyCancellable?
    var homeScrapCancellable: AnyCancellable?
    
    @Published public var seachUserFlavorCodeModel: SearchUserPrefCodeModel?
    var seachUserFlavopCancellable: AnyCancellable?
    
    @Published public var isShowDetailView:Bool = false
    @Published public var detailViewInfo: DetailViewInfo = DetailViewInfo(colorSet: CharacterColor(icon: .basicBlack, iconBackground: .basicBlack, background: .basicBlack),
                                                                          cardInfomation: CardInfomation(stageNum: 1, hashtags: .init(flavor: .light, source: .animation, mood: .condolence), image: "", title: "", sources: "", isBookrmark: false),
                                                                          imageNameAndText: UserCustomBreadViewInfo(userCustomFlavorImageName: "", userCustomSourceIconImageName: "", userCustomMoodImageName: "", userCustomBackgroundImageName: ""))
    
    //MARK: HomeBakeing 관련
    @Published public var exploreViewSearchBarText: String = ""
    @Published public var randomInt = (1...2).randomElement()!
    
    @Published public var choicedBread: Bread?
    @Published public var choicedIngredent: Ingredent?
    @Published public var choicedTopping: Topping?
    
    @Published public var tmpChoicedBread: Bread?
    @Published public var tmpChoicedIngredent: Ingredent?
    @Published public var tmpChoicedTopping: Topping?
    
    
    @Published public var cards: [CardInfomation] = []
    
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
    
    
    public func generateImageNameAndText(hashtags: Hashtags) -> UserCustomBreadViewInfo {
        var flavorAndGenre: UserCustomBreadViewInfo = UserCustomBreadViewInfo(userCustomFlavorImageName: "", userCustomSourceIconImageName: "", userCustomMoodImageName: "", userCustomBackgroundImageName: "'")
        
        switch hashtags.flavor {
        case .light:
            flavorAndGenre.userCustomFlavorImageName = "lightImage"
            flavorAndGenre.userCustomBackgroundImageName = "CardBG_Mild_\(randomInt)"
        case .spicy:
            flavorAndGenre.userCustomFlavorImageName = "spicyImage"
            flavorAndGenre.userCustomBackgroundImageName = "CardBG_Hot_\(randomInt)"
        case .sweet:
            flavorAndGenre.userCustomFlavorImageName = "sweetImage"
            flavorAndGenre.userCustomBackgroundImageName = "CardBG_Sweet_\(randomInt)"
        case .salty:
            flavorAndGenre.userCustomFlavorImageName = "saltyImage"
            flavorAndGenre.userCustomBackgroundImageName = "CardBG_Salty_\(randomInt)"
        case .nutty:
            flavorAndGenre.userCustomFlavorImageName = "nuttyImage"
            flavorAndGenre.userCustomBackgroundImageName = "CardBG_nutty_\(randomInt)"
        }
        
        switch hashtags.source {
        case .animation:
            flavorAndGenre.userCustomSourceIconImageName = "animeImage"
        case .book:
            flavorAndGenre.userCustomSourceIconImageName = "bookImage"
        case .drama:
            flavorAndGenre.userCustomSourceIconImageName = "dramaImage"
        case .famous:
            flavorAndGenre.userCustomSourceIconImageName = "celeImage"
        case .greatMan:
            flavorAndGenre.userCustomSourceIconImageName = "greatmanImage"
        }
        
        switch hashtags.mood {
        case .condolence:
            flavorAndGenre.userCustomMoodImageName = "condolenceImage"
        case .motive:
            flavorAndGenre.userCustomMoodImageName = "motiveImage"
        case .wisdom:
            flavorAndGenre.userCustomMoodImageName = "wisdomImage"
        }
        
        return flavorAndGenre
    }
    
//    func filterPostsByText() {
//        if exploreViewSearchBarText.isEmpty {
//            homePosts = originHomePosts
//        } else {
//            homePosts = originHomePosts.filter { $0.title.contains(exploreViewSearchBarText)
//            }
//        }
//    }
    
    public func updateDetailViewInfo(colorSet: CharacterColor, cardInfomation: CardInfomation, imageNameAndText: UserCustomBreadViewInfo){
        self.detailViewInfo = DetailViewInfo(colorSet: colorSet, cardInfomation: cardInfomation, imageNameAndText: imageNameAndText)
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
            .filter{ choicedBread == nil || $0.hashtags.source.type.breadImageName == choicedBread }
            .filter{ choicedIngredent == nil || $0.hashtags.flavor.type.ingredentImageName == choicedIngredent }
            .filter{ choicedTopping == nil || $0.hashtags.mood.type.toppingImageName == choicedTopping}
        guard let ramdomIndex = (0..<filteredPosts.count).randomElement() else { return cards[0] }
        
        return filteredPosts[ramdomIndex]
    }
    
    
    public func searchCharacterColor(flavor: Flavor) -> CharacterColor {
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
    
    
    
        public func userPrefToViewModel(_ list: UserPrefModel) {
            self.homeUserPrefModel = list
        }
    
        public func userSearchUserCommCodeToViewModel(_ list: SearchUserPrefCodeModel) {
            self.seachUserFlavorCodeModel = list
        }
    
        public func userSearchUserCommCodeRequest(userID: String) {
            if let cancellable = seachUserFlavopCancellable {
                cancellable.cancel()
            }
    
            let provider = MoyaProvider<AuthorizationService>(plugins: [MoyaLoggingPlugin()])
            seachUserFlavopCancellable = provider.requestWithProgressPublisher(.searchUserByUid(uid: userID))
                .compactMap { $0.response?.data }
                .receive(on: DispatchQueue.main)
                .decode(type: SearchUserPrefCodeModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        print("네트워크에러", error.localizedDescription)
                    }
                }, receiveValue: { [weak self] model in
                    if model.status == NetworkCode.success.status {
                        self?.userSearchUserCommCodeToViewModel(model)
                        print("유저 코드", model)
                    } else {
                        self?.userSearchUserCommCodeToViewModel(model)
                        print("유저 코드", model)
                    }
                })
    
        }
    
    
}

public struct DetailViewInfo {
    public let colorSet: CharacterColor
    public var cardInfomation: CardInfomation
    public let imageNameAndText: UserCustomBreadViewInfo
}


public struct UserCustomBreadViewInfo {
    public var userCustomFlavorImageName: String
    public var userCustomSourceIconImageName: String
    public var userCustomMoodImageName: String
    public var userCustomBackgroundImageName: String
}
