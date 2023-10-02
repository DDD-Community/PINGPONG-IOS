//
//  HomeViewViewModel.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Model
import Combine
import API
import CombineMoya
import Moya
import Service

public class HomeViewViewModel: ObservableObject {
    
    @AppStorage("isFirstUserPOPUP") public var isFirstUserPOPUP: Bool = false
    
    @Published var selectedTab: Tab = .home
//    @Published var customTabs: [CustomTab] = []
    
    //MARK: 모달 관련
    @Published var offsetY: CGFloat = 0
    func generateIsButtonAble(situationFlavorSourceTitle: SituationFlavorSourceTitle) -> Bool {
        
        let situationFlavorSourceArray = searchViewButtonInfoArray.filter{ $0.title == situationFlavorSourceTitle }
        let count = situationFlavorSourceArray.filter { $0.options[0].isCheck }.count
        //        let totalCount = situationFlavorSourceArray[0].options.count
        return count > 0
    }
    
    //MARK: -  랜덤  명언 조회 api
    @Published public var homeRandomQuoteModel: HomeRandomQuoteModel?
    var homeRandomQuoteCancellable: AnyCancellable?
    
    @Published public var homeUserPrefModel: UserPrefModel?
    var homeUserPrefCancellable: AnyCancellable?
    
    @Published public var homeLikeScrapModel: BaseModel?
    var homeLikeCancellable: AnyCancellable?
    var homeScrapCancellable: AnyCancellable?
    
    @Published public var seachUserFlavorCodeModel: SearchUserPrefCodeModel?
    var seachUserFlavopCancellable: AnyCancellable?
    
    @Published var isShowDetailView:Bool = false
    @Published var detailViewInfo: DetailViewInfo = DetailViewInfo(colorSet: CharacterColor(icon: .basicBlack, iconBackground: .basicBlack, background: .basicBlack), post: Post(stageNum: 1, hashtags: .init(flavor: .light, source: .animation, situation: .condolence), image: "", title: "", sources: "", isBookrmark: false), imageNameAndText: ("","","",""))
    
    //MARK: HomeBakeing 관련
    @Published var exploreViewSearchBarText: String = ""
    @Published var randomInt = (1...2).randomElement()!
    
    @Published var isTodayBake: Bool = false
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
    
    @Published var isAscendingOrder = true
    
    @Published var originHomePosts = [
        Post(stageNum: 0, hashtags: Hashtags(flavor: .nutty, source: .drama, situation: .condolence), image: "safari.fill", title: "절대로 멈출수가 없는것들이 있다. 인간이 '자유'의 답을 찾는 한, 그것들은 절대로 멈추지 않는다. 이건 나는 게 아니야 멋지게 추락하는 거지", sources: "<토이스토리, 1955>", isBookrmark: false),
        Post(stageNum: 4, hashtags: Hashtags(flavor: .salty, source: .animation, situation: .motive), image: "safari.fill", title: "공포는 악이 아니야 그것은 자신의 약함을 안다는 것이다", sources: "<페어리테일>", isBookrmark: false),
        Post(stageNum: 5, hashtags: Hashtags(flavor: .spicy, source: .greatMan, situation: .wisdom), image: "safari.fill", title: "분노는 바보들의 가슴 속에서만 살아간다", sources: "<아인슈타인>", isBookrmark: false),
        Post(stageNum: 6, hashtags: Hashtags(flavor: .nutty, source: .book, situation: .wisdom), image: "safari.fill", title: "그릇이 차면 넘치고, 사람이 자만하면 이지러진다", sources: "<명심보감>", isBookrmark: false),
        Post(stageNum: 7, hashtags: Hashtags(flavor: .light, source: .greatMan, situation: .motive), image: "safari.fill", title: "작은 도끼라도 찍고 찍으면 큰 참나무는 넘어진다", sources: "<세익스피어>", isBookrmark: false),
        Post(stageNum: 8, hashtags: Hashtags(flavor: .spicy, source: .greatMan, situation: .motive), image: "safari.fill", title: "1퍼센트의 가능성, 그것이 나의 길이다", sources: "<나폴레옹>", isBookrmark: false),
        Post(stageNum: 9, hashtags: Hashtags(flavor: .nutty, source: .famous, situation: .wisdom), image: "safari.fill", title: "안심하면서 먹는 한 조각 빵이 근심하면서 먹는 잔치보다 낫다", sources: "<이솝>", isBookrmark: false),
        Post(stageNum: 10, hashtags: Hashtags(flavor: .spicy, source: .greatMan, situation: .wisdom), image: "safari.fill", title: "게으름은 쇠붙이의 녹과 같다 노동보다도 더 심신을 소모시킨다", sources: "<프랭클린>", isBookrmark: false),
        Post(stageNum: 11, hashtags: Hashtags(flavor: .sweet, source: .famous, situation: .motive), image: "safari.fill", title: "기회는 새와 같은 것, 날아가기 전에 꼭 잡아라", sources: "<스마일즈>", isBookrmark: false),
        Post(stageNum: 12, hashtags: Hashtags(flavor: .spicy, source: .animation, situation: .condolence), image: "safari.fill", title: "아픈 과거는 잊는 것이 아니라 받아들이는 것이다", sources: "<나루토>", isBookrmark: false),
        Post(stageNum: 13, hashtags: Hashtags(flavor: .sweet, source: .animation, situation: .condolence), image: "safari.fill", title: "평범하다는 것은, 단지 아직 자신의 특별함을 발견하지 못했다는 것뿐이야", sources: "<도라에몽>", isBookrmark: false),
        Post(stageNum: 14, hashtags: Hashtags(flavor: .salty, source: .famous, situation: .wisdom), image: "safari.fill", title: "니가 아는 거라 곤 니가 다 아는 줄 아는 것 뿐이다", sources: "<유병재>", isBookrmark: false),
        Post(stageNum: 15, hashtags: Hashtags(flavor: .spicy, source: .drama, situation: .motive), image: "safari.fill", title: "아무리 빨리 이 새벽을 맞아도 어김없이 길에는 사람들이 있었다. 남들이 아직 꿈속을 헤맬 거라 생각했지만 언제나 그렇듯 세상은 나보다 빠르다", sources: "<미생>", isBookrmark: false),
        Post(stageNum: 16, hashtags: Hashtags(flavor: .sweet, source: .drama, situation: .wisdom), image: "safari.fill", title: "사랑하고 일하고, 일하고 사랑하라! 그게 삶의 전부다.", sources: "<인턴>", isBookrmark: false),
        Post(stageNum: 17, hashtags: Hashtags(flavor: .sweet, source: .drama, situation: .condolence), image: "safari.fill", title: "살아가면서 너무 늦거나 이른 것은 없어. 넌 뭐든 될 수 있단다. 조금이라도 후회가 생긴다면 용기를 내서 다시 시작하렴", sources: "<벤자민 버튼의 시간은 거꾸로 간다>", isBookrmark: false),
        Post(stageNum: 18, hashtags: Hashtags(flavor: .salty, source: .drama, situation: .wisdom), image: "safari.fill", title: "당한 만큼 배로 갚아준다.", sources: "<한자와 나오키>", isBookrmark: false),
        Post(stageNum: 19, hashtags: Hashtags(flavor: .spicy, source: .drama, situation: .motive), image: "safari.fill", title: "강한 사람이 아니어도 괜찮습니다. 우리는 서로 도울 거니까요.", sources: "<스토브리그>", isBookrmark: false),
        Post(stageNum: 15, hashtags: Hashtags(flavor: .sweet, source: .drama, situation: .condolence), image: "safari.fill", title: "넌 내 삶의 빛이고, 가장 소중한 보물이란다, 나의 작은 스타.", sources: "<가디언즈 오브 갤럭시>", isBookrmark: false),
        Post(stageNum: 16, hashtags: Hashtags(flavor: .sweet, source: .animation, situation: .motive), image: "safari.fill", title: "희망은 우리가 받은 가장 위대한 선물이에요.", sources: "<미녀와 야수>", isBookrmark: false),
        Post(stageNum: 17, hashtags: Hashtags(flavor: .salty, source: .book, situation: .wisdom), image: "safari.fill", title: "집을 이룰 아이는 인분도 금처럼 아끼고, 집을 망칠 아이는 금도 인분처럼 쓴다.", sources: "<명심보감>", isBookrmark: false),
        Post(stageNum: 18, hashtags: Hashtags(flavor: .light, source: .book, situation: .motive), image: "safari.fill", title: "뿌리가 튼튼해야 열매가 많다.", sources: "<용비어천가>", isBookrmark: false)
    ]
    
    @Published var homePosts = [
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
    
    func searchCheckCount(idx: Int) -> Int {
        return searchViewButtonInfoArray[idx].options.filter { $0.isCheck }.count
    }
    
    public init() {
//        setupCustomTabs(homePosts: homePosts)
        isFirstUserPOPUP = UserDefaults.standard.bool(forKey: "isFirstUserPOPUP")
        
        
    }
    
//    private func setupCustomTabs(homePosts: [Post]) {
//        let homeView = HomeView(viewModel: self)
//        let exploreView = ExploreView(viewModel: self)
//        let arhiveView = ArchiveView(viewModel: self)
//        let customTabHome = CustomTab(name: "홈", imageName: "homeTap", tab: .home, view: AnyView(homeView), isOn: false)
//        let customTabSafari = CustomTab(name: "탐색", imageName: "exploreTap", tab: .explore, view: AnyView(exploreView), isOn: false)
//        let customTabArchive = CustomTab(name: "보관함", imageName: "archiveTap", tab: .archive, view: AnyView(arhiveView), isOn: false)
//        
//        customTabs = [customTabHome, customTabSafari, customTabArchive]
//    }
    
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
    
    func filterPostsByText() {
        if exploreViewSearchBarText.isEmpty {
            homePosts = originHomePosts
        } else {
            homePosts = originHomePosts.filter { $0.title.contains(exploreViewSearchBarText)
            }
        }
    }
    
    func updateDetailViewInfo(colorSet: CharacterColor, post: Post, imageNameAndText: (String, String, String, String)){
        self.detailViewInfo = DetailViewInfo(colorSet: colorSet, post: post, imageNameAndText: imageNameAndText)
    }
    
    func searchPostIndex(post: Post) -> Int {
        for index in homePosts.indices {
            if homePosts[index] == post {
                return index
            }
        }
        return 0
    }
    
    func generateCardByCondition() -> Post {
        let filteredPosts: [Post] = homePosts
            .filter{ choicedBread == nil || $0.hashtags.source.bread == choicedBread }
            .filter{ choicedIngredent == nil || $0.hashtags.flavor.ingredent == choicedIngredent }
            .filter{ choicedTopping == nil || $0.hashtags.situation.topping == choicedTopping}
        guard let ramdomIndex = (0..<filteredPosts.count).randomElement() else { return homePosts[0] }
        
        return filteredPosts[ramdomIndex]
    }
    
    
        //MARK: - api 통신
    
        public func randomQuoteToViewModel(_ list: HomeRandomQuoteModel){
            self.homeRandomQuoteModel = list
        }
    
        public func randomQuoteRequest(userID: String) {
            if let cancellable = homeRandomQuoteCancellable {
                cancellable.cancel()
            }
    
            let provider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
            homeRandomQuoteCancellable = provider.requestWithProgressPublisher(.homeRandomQuote(page: 1, sizePerPage: 50, userId: userID))
                .compactMap { $0.response?.data }
                .receive(on: DispatchQueue.main)
                .decode(type: HomeRandomQuoteModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        print("네트워크에러", error.localizedDescription)
                    }
                }, receiveValue: { [weak self] model in
                    if model.status == NetworkCode.sucess.status {
                        self?.randomQuoteToViewModel(model)
                        print("홈 핸덤 명언 조회", model)
                    } else {
                        self?.randomQuoteToViewModel(model)
                        print("홈 핸덤 명언 조회 실패", model)
                    }
                })
    
        }
    
    
    
        public func homeLikeScrapToViewModel(_ list: BaseModel) {
            self.homeLikeScrapModel = list
        }
    
    
    
        public func userPrefRequest(userID: String, quoteId: Int, isScarp: Bool) {
            if isScarp {
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
                        if model.status == NetworkCode.sucess.status {
                            self?.homeLikeScrapToViewModel(model)
                            print("홈 취향", model)
                        } else {
                            self?.homeLikeScrapToViewModel(model)
                            print("홈 취향", model)
                        }
                    })
            } else {
                if let cancellable = homeScrapCancellable {
                    cancellable.cancel()
                }
    
                let provider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
                homeScrapCancellable = provider.requestWithProgressPublisher(.homeLike(userId: userID, quoteId: quoteId))
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
                        if model.status == NetworkCode.sucess.status {
                            self?.homeLikeScrapToViewModel(model)
                            print("홈 좋아요", model)
                        } else {
                            self?.homeLikeScrapToViewModel(model)
                            print("홈 좋아요", model)
                        }
                    })
            }
    
        }
    
        public func userPrefToViewModel(_ list: UserPrefModel) {
            self.homeUserPrefModel = list
        }
    
    
        public func userPrefRequest(userID: String) {
            if let cancellable = homeUserPrefCancellable {
                cancellable.cancel()
            }
    
            let provider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
            homeUserPrefCancellable = provider.requestWithProgressPublisher(.userPref(userId: userID))
                .compactMap { $0.response?.data }
                .receive(on: DispatchQueue.main)
                .decode(type: UserPrefModel.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        print("네트워크에러", error.localizedDescription)
                    }
                }, receiveValue: { [weak self] model in
                    if model.status == NetworkCode.sucess.status {
                        self?.userPrefToViewModel(model)
                        print("유저 취향 조회", model)
                    } else {
                        self?.userPrefToViewModel(model)
                        print("유저 취향 조회", model)
                    }
                })
    
        }
    
        public func userSearchUserCommCodeToViewModel(_ list: SearchUserPrefCodeModel) {
            self.seachUserFlavorCodeModel = list
        }
    
        public func  userSearchUserCommCodeRequest(userID: String) {
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


struct DetailViewInfo {
    let colorSet: CharacterColor
    var post: Post
    let imageNameAndText: (String, String, String, String)
}





protocol SituationFlavorSourceTitleDelegate {
    
}
