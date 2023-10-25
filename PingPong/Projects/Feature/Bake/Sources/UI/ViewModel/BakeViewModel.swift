//
//  BakeViewModel.swift
//  Bake
//
//  Created by 서원지 on 10/14/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Model
import Combine
import API
import CombineMoya
import Moya
import Service
import OSLog



public class BakeViewModel: ObservableObject {
    @Published public var commonCodeModel: CommonCdModel?
    var commonCodeCancellable: AnyCancellable?
    
    @Published public var bakeQuoteModel: BaseModel?
    var bakeQuoteCancellable: AnyCancellable?
    
    
    public init() {
        
    }
    
    public func commCodeToViewModel(_ list: CommonCdModel) {
        self.commonCodeModel = list
    }

    public func commCodeRequest(commCdTpCd: CommonType) {
        if let cancellable = commonCodeCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<SearchService>(plugins: [MoyaLoggingPlugin()])
        commonCodeCancellable = provider.requestWithProgressPublisher(.searchCommCode(commCdTpCd: commCdTpCd.description))
            .compactMap { $0.response?.data }
            .receive(on: DispatchQueue.main)
            .decode(type: CommonCdModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.success.status {
                    self?.commCodeToViewModel(model)
                    os_log("유저 코드")
                  
                    print("유저 코드", model)
                 
                } else {
                    self?.commCodeToViewModel(model)
                   
                    print("유저 코드", model)
                   
                }
            })
    }
    
    public func bakequoteCodeToViewModel(_ list: BaseModel) {
        self.bakeQuoteModel = list
    }
    
    public func bakeQuoteRequest(userId: String, flavor: String, source: String, mood: String) {
        if let cancellable = bakeQuoteCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
        bakeQuoteCancellable = provider.requestWithProgressPublisher(.homeBakeQuote(userId: userId, flavor: flavor, source: source, mood: mood))
            .compactMap { $0.response?.data}
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
                self?.bakequoteCodeToViewModel(model)
                os_log("홈화면 랜덤 명언 굽기")
                print("홈화면 랜덤 명언 굽기", model)
            })
    }
}


