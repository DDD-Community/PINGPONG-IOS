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
    
    
    func generateSourceBreadImage(commCd: String) -> String {
        switch commCd {
        case "greatman":
            return "carouselgreatmanImage"
        case "celeb":
            return "carouselceleImage"
        case "film":
            return "carouseldramaImage"
        case "anime" :
            return "carouselanimeImage"
        case "book" :
            return "carouselbookImage"
       
        default:
            ""
        }
        return commCd
    }
    
    func generateSourceBreadText(commCd: String) -> String {
        switch commCd {
        case "greatman":
            return "식빵"
        case "celeb":
            return "크로아상"
        case "film":
            return "크로아상"
        case "anime" :
            return "쿠키"
        case "book" :
            return "치아바타"
       
        default:
            ""
        }
        return commCd
    }
    
    
    func generateFlavorIngredentImage(commCd: String) -> String {
        switch commCd {
        case "sweet":
            return "carouselsweetImage"
        case "salty":
            return "carouselsaltyImage"
        case "spicy":
            return "carouselspicyImage"
        case "nutty" :
            return "carouselnuttyImage"
        case "mild" :
            return "carousellightImage"
       
        default:
            ""
        }
        return commCd
    }
    
    func generateFlavorIngredentText(commCd: String) -> String {
        switch commCd {
        case "sweet":
            return "초콜릿"
        case "salty":
            return "치즈"
        case "spicy":
            return "할라피뇨"
        case "nutty" :
            return "생크림"
        case "mild" :
            return "옥수수"
       
        default:
            ""
        }
        return commCd
    }
    
    
    func generateMoodTopicingImage(commCd: String) -> String {
        switch commCd {
        case "motivation":
            return "carouselcondolenceImage"
        case "support":
            return "carouselmotiveImage"
        case "wisdom":
            return "carouselwisdomImage"
        default:
            ""
        }
        return commCd
    }
    
    func generateMoodTopicingText(commCd: String) -> String {
        switch commCd {
        case "motivation":
            return "사과잼"
        case "support":
            return "캬라멜시럽"
        case "wisdom":
            return "밤"
       
        default:
            ""
        }
        return commCd
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


