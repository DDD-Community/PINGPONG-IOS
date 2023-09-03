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
    @Published var LoginSettingView: Bool = false
    
    @Published var goToFavoriteViseView: Bool = false
    
    
    @Published var nickname: String = ""
    
    @Published var nicknameValidation: NicknameValidationType = .notValidated    
    @Published var validationText: String = ""
    @Published var validationColor: Color = .basicGray4
    @Published var validationImageName: String?
    @Published var selectedJob: String? = nil
    @Published var selectJobCode: Int = .zero
    
    let unicodeArray: [Character] = CheckRegister.generateUnicodeArray()
    
    var checkAgreementStatus: Bool {
        return checkTermsService && checkPesonalInformation
    }
    
    var checkAllAgreeStatus: Bool {
        return checkTermsService && checkPesonalInformation && checkReciveMarketingInformation
    }
    
    public init() {}
    
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
                    print("사용자 취향 관련한 명언 공통코드 맛/출처 조회", model)
                } else {
                    self?.onBoardingSearchUserToViewModel(model)
                    print("사용자 취향 관련한 명언 공통코드 맛/출처 조회", model)
                    self?.appState.netWorkErrorPOP = true
                }
            })
    }
    
}



