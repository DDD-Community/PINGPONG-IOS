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

final class OnBoardingViewModel: ObservableObject {
    
    //MARK: -  사용자 취향 코드 모델
    
    var onBoardingSearchUserCancellable: AnyCancellable?
    @Published var onBoardingSearchUserModel: onBoardingUserPreferenceModel?
    @Published var appState: OnBoardingAppState = OnBoardingAppState()
    
    @Published var allAgreeCheckButton: Bool = false
    @Published var checkTermsService: Bool = false
    @Published var checkPesonalInformation: Bool = false
    @Published var checkReciveMarketingInformation: Bool = false
    @Published var allConfirmAgreeView: Bool = false
    @Published var goToFavoriteViseView: Bool = false
    
    @Published var nickname: String = ""
    
    @Published var nicknameValidation: NicknameValidationType = .notValidated    
    @Published var validationText: String = " "
    @Published var validationColor: Color = .basicGray4
    @Published var validationImageName: String?
    
    let unicodeArray: [Character] = generateUnicodeArray()
    
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
    public func allValidateNikname(nicknameValidate: Bool){
        if !nicknameValidate {
            self.nicknameValidation = .invalid
        } else {
            self.nicknameValidation = .valid
        }
        
        self.validationText = generateValidationText(validation: self.nicknameValidation)
        self.validationColor = generateValidationColor(validation: self.nicknameValidation)
        self.validationImageName = generateValidationImage(validation: self.nicknameValidation)
    }
    
    public func validateNickname(nickname: String) -> Bool {
        if nickname.count < 1 || nickname.count > 12 { return false }
        for character in nickname {
            if !self.unicodeArray.contains(character) { return false }
        }
        return true
    }
    
    public func generateValidationColor(validation: NicknameValidationType) -> Color {
        switch validation {
        case .duplicate: return Color.statusWarning
        case .invalid: return Color.statusWarning
        case .notValidated: return Color.basicGray5
        case .valid: return Color.statusSuccess
        }
    }
    
    public func generateValidationText(validation: NicknameValidationType) -> String {
        switch validation {
        case .duplicate: return "이미 사용중인 닉네임이에요."
        case .invalid: return "닉네임 형식이 올바르지 않아요.  *특수문자 제외 12자 이하"
        case .notValidated: return ""
        case .valid: return "사용 가능한 닉네임이에요!"
        }
    }
    
    public func generateValidationImage(validation: NicknameValidationType) -> String? {
        switch validation {
        case .duplicate: return "exclamationmark.circle"
        case .invalid: return "exclamationmark.circle"
        case .notValidated: return nil
        case .valid: return "checkmark.circle"
        }
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
}

public func generateUnicodeArray() -> [Character] {
    var unicodeArray: [Character] = []
    let unicodeRanges = [
        UnicodeRange(unicodeType: .korean, from: 0xAC00, to: 0xD7A4),
        UnicodeRange(unicodeType: .number, from: 0x0030, to: 0x0039),
        UnicodeRange(unicodeType: .english, from: 0x0041, to: 0x005B),
        UnicodeRange(unicodeType: .english, from: 0x0061, to: 0x007B)
    ]
    
    unicodeRanges.forEach { unicode in
        let unicodeComponentArray = generateComponentUnicodeArray(from: unicode.from, to: unicode.to)
        unicodeArray += unicodeComponentArray
    }
    return unicodeArray
}


public func generateComponentUnicodeArray(from: Int, to: Int) -> [Character]{
    var unicodeArray: [Character] = []
    for codePoint in from..<to {
        if let character = UnicodeScalar(codePoint) {
            unicodeArray.append(Character(character))
        }
    }
    return unicodeArray
}

struct UnicodeRange {
    let unicodeType: UnicodeType
    let from: Int
    let to: Int
}

enum UnicodeType {
    case korean
    case english
    case number
}

enum NicknameValidationType {
    case notValidated
    case valid
    case invalid
    case duplicate
}
