//
//  OnBoardingViewModel.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/07/01.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI
import Service
import Combine
import CombineMoya
import Model
import Moya
import API
import DesignSystem

public class OnBoardingViewModel: ObservableObject {
    
    @Published var appState: OnBoardingAppState = OnBoardingAppState()
    
    //MARK: -  사용자 취향 코드 모델
    var onBoardingSearchUserCancellable: AnyCancellable?
    @Published var onBoardingSearchUserModel: onBoardingUserPreferenceModel?
    
    
    @Published var allAgreeCheckButton: Bool = false
    @Published var checkTermsService: Bool = false
    @Published var checkPesonalInformation: Bool = false
    @Published var checkReciveMarketingInformation: Bool = false
    @Published var allConfirmAgreeView: Bool = false
    
    @Published var isLoginJobSettingView: Bool = false
    @Published var isLoginSettingView: Bool = false
    @Published var isCompleteSignupView: Bool = false
    
    @Published var isStartChoiceFavoritedView: Bool = false
    @Published var isSelectedCategory: Bool = false
    @Published var isSelectedCharacter: Bool = false
    
    
    @Published var goToFavoriteViseView: Bool = false
    
    @Published var nickname: String = ""
    
    @Published var nicknameValidation: NicknameValidationType = .notValidated
    @Published var validationText: String = " "
    @Published var validationColor: Color = .basicGray4
    @Published var validationImageName: String?
    @Published var selectedJob: String? = nil
    @Published var selectedFavorite: [Favorite] = []
    @Published var selectedCharacter: [String] = []
    
    
//    @Published var situationArray: SearchViewButtonInfo =   SearchViewButtonInfo(title: .situation, options:  [SearchOption(val: "우울", detail: "우울해서 빵댕이를 흔들고 싶을 때"),
//                                                                                                               SearchOption(val: "기쁨", detail: "기뻐서 빵댕이를 흔들고 싶을 때"),
//                                                                                                               SearchOption(val: "슬픔", detail: "슬퍼서 빵댕이를 흔들고 싶을 때")])
    
    @Published var flavorArray: SearchViewButtonInfo =  SearchViewButtonInfo(title: .flavor, options:  [
        SearchOption(val: "달콤한 맛", iconImageName: "🍰", detail: "지친 삶의 위로, 기쁨을 주는 명언"),
        SearchOption(val: "짭짤한 맛", iconImageName: "😭", detail: "울컥하게 만드는 감동적인 명언"),
        SearchOption(val: "매콤한 맛", iconImageName: "🔥", detail: "따끔한 조언의 자극적인 명언"),
        SearchOption(val: "고소한 맛", iconImageName: "🥜", detail: "재채있고 유희적인 명언"),
        SearchOption(val: "담백한 맛", iconImageName: "🥖", detail: "언제봐도 좋은 명언")
    ])
    
//    @Published var saurceArray: SearchViewButtonInfo = SearchViewButtonInfo(title: .situation, options:  [
//        SearchOption(val: "위인", detail: "위인의 명언"),
//        SearchOption(val: "애니메이션", detail: "김인호 나마에와 레오"),
//        SearchOption(val: "드라마", detail: "조화? 조흐냐구 웨딩드레스 입으니까 조화?")])
    
    @Published var searchViewButtonInfoArray: [SearchViewButtonInfo] = [
        //        self.situationArray,
        //        flavorArray,
    ]
    
    let unicodeArray: [Character] = CheckRegister.generateUnicodeArray()
    
    var checkAgreementStatus: Bool {
        return checkTermsService && checkPesonalInformation
    }
    
    var checkAllAgreeStatus: Bool {
        return checkTermsService && checkPesonalInformation && checkReciveMarketingInformation
    }
    
    //MARK: -  동의 하는 관련  함수
    func updateAgreementStatus() {
        if !allAgreeCheckButton || !checkTermsService || !checkPesonalInformation || !checkReciveMarketingInformation {
            allAgreeCheckButton = true
            checkTermsService = true
            checkPesonalInformation = true
            checkReciveMarketingInformation = true
        } else {
            allAgreeCheckButton = false
            checkTermsService = false
            checkPesonalInformation = false
            checkReciveMarketingInformation = false
        }
    };
    //MARK: - 닉네임 유효성 검증
    public func allValidateNikname(nicknameValidate: Bool, duplicateValidate: Bool){
        if !nicknameValidate {
            self.nicknameValidation = .invalid
        } else if !duplicateValidate {
            self.nicknameValidation = .duplicate
        } else {
            self.nicknameValidation = .valid
        }
        
        self.validationText = CheckRegister.generateValidationText(validation: self.nicknameValidation)
        self.validationColor = CheckRegister.generateValidationColor(validation: self.nicknameValidation)
        self.validationImageName = CheckRegister.generateValidationImage(validation: self.nicknameValidation)
    }
    
    public func validateNickname(nickname: String) -> Bool {
        if nickname.count < 1 || nickname.count > 12 { return false }
        for character in nickname {
            if !self.unicodeArray.contains(character) { return false }
        }
        return true
    }
    
    //MARK: -  사용자 취향 관련한 명언 공통코드 맛/출처 조회
    public func onBoardingSearchUserToViewModel(_ list: onBoardingUserPreferenceModel) {
        self.onBoardingSearchUserModel = list
    }
    
    
    public func onBoardingSearchUserRequest() {
        if let cancellable =  onBoardingSearchUserCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<OnBoardingService>(plugins: [MoyaLoggingPlugin()])
        onBoardingSearchUserCancellable = provider.requestWithProgressPublisher(.searchUserPreferenceRegister)
            .compactMap{ $0.response?.data}
            .handleEvents(receiveSubscription: { _ in
                self.appState.netWorkErrorPOP = true
            }, receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    self?.appState.netWorkErrorPOP = false
                case .failure(let error):
                    self?.appState.errorMessage = error.localizedDescription
                    self?.appState.netWorkErrorPOP = true
                }
                self?.appState.netWorkErrorPOP = true
                
            }, receiveCancel: {
                // Handle cancellation if needed
                self.appState.netWorkErrorPOP = false
                
            })
            .receive(on: DispatchQueue.main)
            .decode(type: onBoardingUserPreferenceModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    self?.appState.errorMessage = error.localizedDescription
                    self?.appState.netWorkErrorPOP = true
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.sucess.status {
                    self?.onBoardingSearchUserToViewModel(model)
                    print("용자 취향 관련한 명언 공통코드 맛/출처 조회", model)
                } else {
                    self?.onBoardingSearchUserToViewModel(model)
                    print("용자 취향 관련한 명언 공통코드 맛/출처 조회", model)
                    self?.appState.netWorkErrorPOP = true
                }
            })
    }
    
    //MARK: favorite 관련
    func appendAndPopFavorite(favorite: Favorite) {
        guard self.selectedFavorite.count < 2 || self.selectedFavorite.contains(favorite) else { return }
        
        if self.selectedFavorite.contains(favorite) {
            guard let index = self.selectedFavorite.firstIndex(of: favorite) else { return }
            self.selectedFavorite.remove(at: index)
        } else {
            self.selectedFavorite.append(favorite)
        }
    }
    
    func searchCharacterColor(flavor: Flavor) -> CharacterColor {
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
    
    //MARK: favorite character 관련
    func appendAndPopCharacter(character: String, index: Int) {
        guard self.selectedCharacter.count < 2 || self.selectedCharacter.contains(character) else { return }
        
        if self.selectedCharacter.contains(character) {
            guard let arrayIndex = self.selectedCharacter.firstIndex(of: character) else { return }
            self.selectedCharacter.remove(at: arrayIndex)
            self.flavorArray.options[index].isCheck = false
        } else {
            self.selectedCharacter.append(character)
            self.flavorArray.options[index].isCheck = true
        }
    }
    
}

enum Favorite: String {
    case anime
    case book
    case celeb
    case film
    case greatman
    case proverb
}

struct SearchViewButtonInfo: Identifiable, SearchViewButtonInfoProtocol {
    var title: SearchType
    
    var shouldShowDropdown = false
    let id: UUID = UUID()
    
    var options: [SearchOption]
    var onSelect: ((_ key: String) -> Void)?
}

protocol SearchViewButtonInfoProtocol {
    var title: SearchType { get }
}

enum SearchType: String {
    case situation = "상황"
    case flavor = "맛"
    case source = "출처"
}


struct SearchOption: Hashable, Identifiable {
    let id: UUID = UUID()
    var val: String
    var iconImageName: String
    var detail: String
    var isCheck: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(detail)
        hasher.combine(val)
    }
    
    static func == (lhs: SearchOption, rhs: SearchOption) -> Bool {
        return lhs.detail == rhs.detail && lhs.val == rhs.val
    }
}

struct CharacterColor {
    let icon: Color
    let iconBackground: Color
    //    let filter: Color
    let background: Color
}

enum Flavor: String {
    case sweet = "달콤한 맛"
    case salty = "짭짤한 맛"
    case spicy = "매콤한 맛"
    case nutty = "고소한 맛"
    case light = "담백한 맛"
}
