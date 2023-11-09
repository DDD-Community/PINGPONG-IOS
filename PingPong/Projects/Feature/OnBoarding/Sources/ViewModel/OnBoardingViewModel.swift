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
    @Published var onBoardingSearchUserModel: CommonCodeModel?
    
    var onBoardingRegisterFlavorCancellable: AnyCancellable?
    @Published var onBoardingRegisterFlavor: OnBoardingRegisterFlavorModel?
    
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
    @Published var isSkipSelectedCategory: Bool = false
    @Published var isSkipSelectedFlavor: Bool = false
    @Published var isSelectedCharacter: Bool = false
    @Published var goToLoginView: Bool = false
    @Published public var inviteMainView: Bool = false
    
    
    @Published var goToFavoriteViseView: Bool = false
    
    
    @Published var nickname: String = ""
    
    @Published var nicknameValidation: NicknameValidationType = .notValidated
    @Published var validationText: String = " "
    @Published var validationColor: Color = .basicGray4
    @Published var validationImageName: String?
    @Published var selectedJob: String? = nil
    @Published var selectJobCode: Int = .zero
    @Published var selectedFavoriteCategory: String = ""
    @Published var selectedFavoriteFlavor: String = ""
    @Published var selectedFavorite: [Favorite] = []
    @Published var selectedCharacter: [String] = []
    @Published public var isSignUP: Bool = false
    @AppStorage("completdSignUP") public var completdSignUP: Bool = false
    @Published public var alreadySignUP: Bool = false
    @AppStorage("isFirstUserPOPUP") public var isFirstUserPOPUP: Bool = false

    let unicodeArray: [Character] = CheckRegister.generateUnicodeArray()
    
    @Published var flavorArray: SearchViewButtonInfo =  SearchViewButtonInfo(title: .flavor, options:  [
        SearchOption(korean: "달콤한 맛", english: "sweet", iconImageName: "🍰", detail: "지친 삶의 위로, 기쁨을 주는 명언"),
        SearchOption(korean: "짭잘한 맛", english: "salty", iconImageName: "😭", detail: "울컥하게 만드는 감동적인 명언"),
        SearchOption(korean: "매콤한 맛", english: "spicy", iconImageName: "🔥", detail: "따끔한 조언의 자극적인 명언"),
        SearchOption(korean: "고소한 맛", english:"nutty", iconImageName: "🥜", detail: "재치있고 유희적인 명언"),
        SearchOption(korean: "담백한 맛", english: "light", iconImageName: "🥖", detail: "언제봐도 좋은 명언")
    ])
    

    public func searchFlavorIndex(commNm: String) -> Int {
        for index in flavorArray.options.indices {
            if flavorArray.options[index].korean == commNm {
                return index
            }
        }
        return .zero
    }
    
    
    
    var checkAgreementStatus: Bool {
        return checkTermsService && checkPesonalInformation
    }
    
    var checkAllAgreeStatus: Bool {
        return checkTermsService && checkPesonalInformation && checkReciveMarketingInformation
    }
    
    
    public init() {
        isFirstUserPOPUP = UserDefaults.standard.bool(forKey: "isFirstUserPOPUP")
        isSignUP = UserDefaults.standard.bool(forKey: "isSignUP")
        completdSignUP = UserDefaults.standard.bool(forKey: "completdSignUP")
        alreadySignUP = UserDefaults.standard.bool(forKey: "alreadySignUP")
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
    public func onBoardingSearchUserToViewModel(_ list: CommonCodeModel) {
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
            .decode(type: CommonCodeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    self?.appState.errorMessage = error.localizedDescription
                    self?.appState.netWorkErrorPOP = true
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.success.status {
                    self?.onBoardingSearchUserToViewModel(model)
                    print("사용자 취향 관련한 명언 공통코드 맛/출처 조회", model)
                } else {
                    self?.onBoardingSearchUserToViewModel(model)
                    print("사용자 취향 관련한 명언 공통코드 맛/출처 조회", model)
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
    
    func searchCharacterColor(flavor: Flavor) -> FlavorColor {
        switch flavor {
        case .sweet: return FlavorColor(icon: .sweetIconText,
                                           iconBackground: .sweetIconBG,
                                           background: .sweetBG)
        case .light: return FlavorColor(icon: .mildIconText,
                                           iconBackground: .mildIconBG,
                                           background: .mildBG)
        case .nutty: return  FlavorColor(icon: .nuttyIconText,
                                            iconBackground: .nuttyIconBG,
                                            background: .nuttyBG)
        case .salty: return  FlavorColor(icon: .saltyIconText,
                                            iconBackground: .saltyIconBG,
                                            background: .saltyBG)
        case .spicy: return FlavorColor(icon: .hotIconText,
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
    
    
    //MARK: -  취향  등록
    public func onBoardingRegisterToViewModel(_ list: OnBoardingRegisterFlavorModel) {
        self.onBoardingRegisterFlavor = list
    }
    
    
    public func onBoardingRegisterPost(userId: Int, flavors: [String], sources: [String], failOnBoardingRegsiterAction: @escaping () -> Void) {
        if let cancellable = onBoardingRegisterFlavorCancellable {
            cancellable.cancel()
        }
        let provider = MoyaProvider<OnBoardingService>(plugins: [MoyaLoggingPlugin()])
        onBoardingRegisterFlavorCancellable = provider.requestWithProgressPublisher(.userPreferenceRegister(userId: userId, flavors: flavors, sources: sources))
            .compactMap {$0.response?.data}
            .decode(type: OnBoardingRegisterFlavorModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크 에러 ",error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.success.status {
                    self?.onBoardingRegisterToViewModel(model)
                    print("사용자 취향 등록 성공", model)
                } else {
                    self?.onBoardingRegisterToViewModel(model)
                    print("사용자 취향 등록 실패", model)
                    failOnBoardingRegsiterAction()
                }
            })
    }
}
