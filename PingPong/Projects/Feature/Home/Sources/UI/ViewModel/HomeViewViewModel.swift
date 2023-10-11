//
//  HomeViewViewModel.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import API
import Combine
import SwiftUI
import CombineMoya
import Model
import Moya
import Service


public class HomeViewViewModel: ObservableObject {
    
    //MARK: -  랜덤  명언 조회 api
    @Published public var homeRandomQuoteModel: HomeRandomQuoteModel?
    public var homeRandomQuoteCancellable: AnyCancellable?
    
    @Published public var homeUserPrefModel: UserPrefModel?
    public var homeUserPrefCancellable: AnyCancellable?
    
    @Published public var homeBaseModel: BaseModel?
    var homeLikeCancellable: AnyCancellable?
    var homeScrapCancellable: AnyCancellable?
    
    var homeBakeCancellbale: AnyCancellable?
    
    public init () {
        
    }
    
    
    public func transferFlavor(flavorType: String) -> Flavor {
        switch flavorType {
        case "sweet":
            return .sweet
        case "salty":
            return .salty
        case "spicy":
            return .spicy
        case "nutty":
            return .nutty
        case "light":
            return .light
        default:
            return .sweet
        }
    }
    
    public func transferSource(sourceType: String) -> Sources {
        switch sourceType {
        case "animation":
            return .animation
        case "famous":
            return .famous
        case "book":
            return .book
        case "drama":
            return .drama
        case "greatMan":
            return .greatMan
        default:
            return .animation
        }
    }
    
    
    public func transferMood(moodType: String) -> Situations {
        switch moodType {
        case "condolence":
            return .condolence
        case "motive":
            return .motive
        case "wisdom":
            return .wisdom
        default:
            return .condolence
        }
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
    
    //MARK: -  홈  좋아요  및  스크램 api
    public func homeBaseToViewModel(_ list: BaseModel) {
        self.homeBaseModel = list
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
                        self?.homeBaseToViewModel(model)
                        print("홈 취향", model)
                    } else {
                        self?.homeBaseToViewModel(model)
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
                        self?.homeBaseToViewModel(model)
                        print("홈 좋아요", model)
                    } else {
                        self?.homeBaseToViewModel(model)
                        print("홈 좋아요", model)
                    }
                })
        }
        
        
        
    }
    
    public func homeBakeRequest(userId: String, flavor: String, source: String, mood: String) {
        if let canellable = homeBakeCancellbale {
            canellable.cancel()
        }
        
        let provider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
        homeBakeCancellbale = provider.requestWithProgressPublisher(.homeBakeQuote(userId: userId, flavor: flavor, source: source, mood: mood))
            .compactMap {$0.response?.data}
            .decode(type: BaseModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                self?.homeBaseToViewModel(model)
                print("홈 랜덤  명언 굽기", model)
            })
    }
    
    
    
}
