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

public class ExploreViewModel: ObservableObject {
    
    @Published var searchModel: SearchModel?
    var searchCancellable: AnyCancellable?
    
    
    public init() {
        
    }
    
    public func searchRequestToViewModel(_ list: SearchModel) {
        self.searchModel = list
    }
    
    public func searchRequest(
        keyword: String,
        flavors: [String],
        sources: [String],
        mood: [String],
        orderBy: OrederByType
    ){
        if let cancellable = searchCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<SearchService>(plugins: [MoyaLoggingPlugin()])
        searchCancellable = provider.requestWithProgressPublisher(.searchQuote(page: 1, sizePerPage: 50, keyword: keyword, flavors: flavors, sources: sources, moods: mood, orderBy: orderBy.description))
            .compactMap { $0.response?.data }
            .receive(on: DispatchQueue.main)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크 에러 \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] model in
                self?.searchRequestToViewModel(model)
                print("검색  성공", model)
            })
        
    }
    
}
