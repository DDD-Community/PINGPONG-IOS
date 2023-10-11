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
    @Published public var detailViewInfo: DetailViewInfo = DetailViewInfo(colorSet: CharacterColor(icon: .basicBlack, iconBackground: .basicBlack, background: .basicBlack), post: Post(stageNum: 1, hashtags: .init(flavor: .light, source: .animation, situation: .condolence), image: "", title: "", sources: "", isBookrmark: false), imageNameAndText: ("","","",""))
    
    //MARK: HomeBakeing 관련
    @Published public var exploreViewSearchBarText: String = ""
    @Published public var randomInt = (1...2).randomElement()!
    
    @Published public var choicedBread: Bread?
    @Published public var choicedIngredent: Ingredent?
    @Published public var choicedTopping: Topping?
    
    @Published public var tmpChoicedBread: Bread?
    @Published public var tmpChoicedIngredent: Ingredent?
    @Published public var tmpChoicedTopping: Topping?
    
    
    @Published public var homePosts = [
        Post(stageNum: 0, hashtags: Hashtags(flavor: .salty, source: .animation, situation: .motive), image: "safari.fill", title: "공포는 악이 아니야 그것은 자신의 약함을 안다는 것이다", sources: "페어리테일", isBookrmark: false),
        Post(stageNum: 1, hashtags: Hashtags(flavor: .sweet, source: .greatMan, situation: .motive), image: "safari.fill", title: "분노는 바보들의 가슴 속에서만 살아간다.", sources: "명심보감", isBookrmark: false),
        Post(stageNum: 2, hashtags: Hashtags(flavor: .nutty, source: .book, situation: .wisdom), image: "safari.fill", title: "그릇이 차면 넘치고, 사람이 자만하면 이지러진다", sources: "나폴레옹", isBookrmark: false),
        Post(stageNum: 3, hashtags: Hashtags(flavor: .spicy, source: .greatMan, situation: .condolence), image: "safari.fill", title: "1퍼센트의 가능성, 그것이 나의 길이다", sources: "세익스피어", isBookrmark: false),
        Post(stageNum: 4, hashtags: Hashtags(flavor: .nutty, source: .famous, situation: .motive), image: "safari.fill", title: "안심하면서 먹는 한 조각 빵이 근심하면서 먹는 잔치보다 낫다", sources: "이솝", isBookrmark: false),
        Post(stageNum: 5, hashtags: Hashtags(flavor: .sweet, source: .famous, situation: .wisdom), image: "safari.fill",  title: "게으름은 쇠붙이의 녹과 같다 노동보다도 더 심신을 소모시킨다", sources: "프랭클린", isBookrmark: false),
        Post(stageNum: 6, hashtags: Hashtags(flavor:.salty, source: .famous, situation: .condolence), image: "safari.fill", title: "기회는 새와 같은 것, 날아가기 전에 꼭 잡아라", sources: "스마일즈", isBookrmark: false),
        Post(stageNum: 7, hashtags: Hashtags(flavor: .spicy, source: .animation, situation: .motive), image: "safari.fill", title: "아픈 과거는 잊는 것이 아니라 받아들이는 것이다", sources: "나루토", isBookrmark: false),
        Post(stageNum: 8, hashtags: Hashtags(flavor: .light, source: .famous, situation: .wisdom), image: "safari.fill", title: "니가 아는 거라 곤 니가 다 아는 줄 아는 것 뿐이다.", sources: "유병재", isBookrmark: false),
        Post(stageNum: 9, hashtags: Hashtags(flavor: .nutty, source: .drama, situation: .condolence), image: "safari.fill", title: "아무리 빨리 이 새벽을 맞아도 어김없이 길에는 사람들이 있었다. 남들이 아직 꿈속을 헤맬 거라 생각했지만 언제나 그렇듯 세상은 나보다 빠르다", sources: "미생", isBookrmark: false),
        Post(stageNum: 10, hashtags: Hashtags(flavor: .sweet, source: .animation, situation: .wisdom), image: "safari.fill", title: "평범하다는 것은, 단지 아직 자신의 특별함을 발견하지 못했다는 것뿐이야", sources: "도라에몽", isBookrmark: false),
        Post(stageNum: 11, hashtags: Hashtags(flavor: .nutty, source: .drama, situation: .wisdom), image: "safari.fill", title: "사랑하고 일하고, 일하고 사랑하라! 그게 삶의 전부다.", sources: "인턴", isBookrmark: false),
        Post(stageNum: 12, hashtags: Hashtags(flavor: .salty, source: .drama, situation: .wisdom), image: "safari.fill", title: "살아가면서 너무 늦거나 이른 것은 없어. 넌 뭐든 될 수 있단다. 조금이라도 후회가 생긴다면 용기를 내서 다시 시작하렴", sources: "벤자민 버튼의 시간은 거꾸로 간다", isBookrmark: false),
        Post(stageNum: 13, hashtags: Hashtags(flavor: .spicy, source: .drama, situation: .wisdom), image: "safari.fill", title: "당한 만큼 배로 갚아준다.", sources: "한자와 나오키", isBookrmark: false),
        Post(stageNum: 14, hashtags: Hashtags(flavor: .salty, source: .drama, situation: .motive), image: "safari.fill", title: "강한 사람이 아니어도 괜찮습니다. 우리는 서로 도울 거니까요.", sources: "스토브리그", isBookrmark: false),
        Post(stageNum: 15, hashtags: Hashtags(flavor: .sweet, source: .drama, situation: .condolence), image: "safari.fill", title: "넌 내 삶의 빛이고, 가장 소중한 보물이란다, 나의 작은 스타.", sources: "가디언즈 오브 갤럭시", isBookrmark: false),
        Post(stageNum: 16, hashtags: Hashtags(flavor: .sweet, source: .animation, situation: .condolence), image: "safari.fill", title: "희망은 우리가 받은 가장 위대한 선물이에요.", sources: "미녀와 야수", isBookrmark: false),
        Post(stageNum: 17, hashtags: Hashtags(flavor: .salty, source: .book, situation: .wisdom), image: "safari.fill", title: "집을 이룰 아이는 인분도 금처럼 아끼고, 집을 망칠 아이는 금도 인분처럼 쓴다", sources: "명심보감", isBookrmark: false),
        Post(stageNum: 18, hashtags: Hashtags(flavor: .light, source: .book, situation: .motive), image: "safari.fill", title: "뿌리가 튼튼해야 열매가 많다.", sources: "용비어천가", isBookrmark: false),
        Post(stageNum: 19, hashtags: Hashtags(flavor: .nutty, source: .book, situation: .wisdom), image: "safari.fill", title: "그릇이 차면 넘치고, 사람이 자만하면 이지러진다", sources: "명심보감", isBookrmark: false)
        
        
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
    
    
    public func generateImageNameAndText(hashtags: Hashtags) -> (String, String, String, String) {
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
        
        switch hashtags.source {
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
    
//    func filterPostsByText() {
//        if exploreViewSearchBarText.isEmpty {
//            homePosts = originHomePosts
//        } else {
//            homePosts = originHomePosts.filter { $0.title.contains(exploreViewSearchBarText)
//            }
//        }
//    }
    
    public func updateDetailViewInfo(colorSet: CharacterColor, post: Post, imageNameAndText: (String, String, String, String)){
        self.detailViewInfo = DetailViewInfo(colorSet: colorSet, post: post, imageNameAndText: imageNameAndText)
    }
    
    public func searchPostIndex(post: Post) -> Int {
        for index in homePosts.indices {
            if homePosts[index] == post {
                return index
            }
        }
        return 0
    }
    
    public func generateCardByCondition() -> Post {
        let filteredPosts: [Post] = homePosts
            .filter{ choicedBread == nil || $0.hashtags.source.bread == choicedBread }
            .filter{ choicedIngredent == nil || $0.hashtags.flavor.ingredent == choicedIngredent }
            .filter{ choicedTopping == nil || $0.hashtags.situation.topping == choicedTopping}
        guard let ramdomIndex = (0..<filteredPosts.count).randomElement() else { return homePosts[0] }
        
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
                    if model.status == NetworkCode.sucess.status {
                        self?.userSearchUserCommCodeToViewModel(model)
                        print("유저 코드", model)
                    } else {
                        self?.userSearchUserCommCodeToViewModel(model)
                        print("유저 코드", model)
                    }
                })
    
        }
    
    
}

public extension CommonViewViewModel {
    
    
}


public struct DetailViewInfo {
    public let colorSet: CharacterColor
    public var post: Post
    public let imageNameAndText: (String, String, String, String)
}
