//
//  ExploreViewModel.swift
//  Search
//
//  Created by 서원지 on 10/22/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Service
import Combine
import Moya
import CombineMoya
import Model
import API

public class ExploreViewModel: ObservableObject {
    
    @Published public var searchModel: SearchQuoteModel?
    var searchCancellable: AnyCancellable?
    
    @Published public var optionButtonInfoArray: [OptionButtonInfo] = [OptionButtonInfo(defaultTitle: .situation),
                                                                OptionButtonInfo(defaultTitle: .flavor),
                                                                OptionButtonInfo(defaultTitle: .source)]
    
    public init() {
        
    }
    
    public func searchRequestToViewModel(_ list: SearchQuoteModel) {
        self.searchModel = list
    }
    
    public func searchRequest(
        keyword: String,
        flavors: [String],
        sources: [String],
        mood: [String],
        orderBy: String,
        completion: @escaping () -> Void
    ) async {
        if let cancellable = searchCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<SearchService>(plugins: [MoyaLoggingPlugin()])
        searchCancellable = provider.requestWithProgressPublisher(.searchQuote(page: 0, sizePerPage: 1000, keyword: keyword, flavors: flavors, sources: sources, moods: mood, orderBy: orderBy))
            .compactMap { $0.response?.data }
            .receive(on: DispatchQueue.main)
            .decode(type: SearchQuoteModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크 에러 \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] model in
                if let status = model.status {
                    if status == NetworkCode.success.status {
                        self?.searchRequestToViewModel(model)
                        print("검색 결과 \(model)")
                        completion()
                    }
                }
            })
    }
    
}
