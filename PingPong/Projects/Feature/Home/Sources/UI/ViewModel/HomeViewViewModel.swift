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
    @State var isOn: [Bool] = []
    @Published public var likeYn: Bool = false
    
    @Published public var homeUserPrefModel: UserPrefModel?
    public var homeUserPrefCancellable: AnyCancellable?
    
    @Published public var homeBaseModel: BaseModel?
    
    var homeLikeCancellable: AnyCancellable?
    
    var homeBakeCancellbale: AnyCancellable?
    
    public init () {
        
    }
    
    //MARK: - api 통신
    public func randomQuoteToViewModel(_ list: HomeRandomQuoteModel){
        self.homeRandomQuoteModel = list
    }
    
    public func randomQuoteRequest(userID: String, completion: @escaping () -> Void) {
        if let cancellable = homeRandomQuoteCancellable {
            cancellable.cancel()
        }

        let provider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
        homeRandomQuoteCancellable = provider.requestWithProgressPublisher(.homeRandomQuote(page: 0, sizePerPage: 50, userId: userID))
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
                if model.status == NetworkCode.success.status {
                    self?.randomQuoteToViewModel(model)
                    completion()
                    print("홈 핸덤 명언 조회", model)
                    
                } else {
                    self?.randomQuoteToViewModel(model)
                    print("홈 핸덤 명언 조회 실패", model)
                }
            })

    }
    
    public func homeBaseToViewModel(_ list: BaseModel) {
        self.homeBaseModel = list
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


public enum pingpongError: Error {
    public enum HomeViewError: Error {
        case invalidInput(text: String)
    }
}
