//
//  ProfileViewViewModel.swift
//  Profile
//
//  Created by Byeon jinha on 2023/11/06.
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

public class ProfileViewViewModel: ObservableObject {
     let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    @Published var loadingWebView: Bool = false
    @Published var gotoOtherSettingView: Bool = false
    @Published var gotoNotificationQuoteView: Bool = false
    @Published var gotoPrivacyPolicyView: Bool = false
    @Published var gotoTermsOfServiceView: Bool = false
    @Published var gotoWithDrawView: Bool = false
    @Published var isSelectDropDownMenu: Bool = false
    @Published var selectWithDrawReason: String = "이런 점이 불편했어요."
    @Published public var selectedTime = Date()
    @Published var selectWithDrawPOPUP: Bool = false
    @Published var changeNickNameView: Bool = false
    @Published var changeNickNameSuccessPOPUP: Bool = false
    @Published public var changeNickName: String = ""
    @Published public var changeNickImage: String = "mainHomeLogo"
   
    @AppStorage("selectedChangeTimeView") public var selectedChangeTimeView: Bool = false
    @AppStorage("saveDate") public var saveDate: String = ""
    @AppStorage("saveDateHour") public var saveDateHour: String = ""
    
    @Published public var selectTimeBottomView: Bool = false
    
    @Published public var commonCodeModel: CommonCdModel?
    var randomNameCancellable: AnyCancellable?
    
    @Published var isFirstRequestCompleted = false
    @AppStorage("randomNickName") var randomNickName: String = ""
   
    @Published var nicknameValidation: NicknameValidationType = .notValidated
    @Published public var changeValidationColor: Color = .basicGray4
    @Published public var changeValidationImageName: String?
    @Published public var changeValidationText: String = " "
    @Published public var userNickName: String = ""
    @AppStorage("userPrefId") public var userPrefId: Int = .zero
    
    let unicodeArray: [Character] = CheckRegister.generateUnicodeArray()
    var withDrawCancellable: AnyCancellable?
    
    @Published public var profileUserPrefModel: ProfileUserPrefModel?
    var profileUserPrefCancellable: AnyCancellable?
    
    @Published public var withDrawModel: WithDrawModel?
    var changeNickNameCancellable: AnyCancellable?
    
    @Published public var baseModel: BaseModel?
    var changeUserPrefEditCancellable: AnyCancellable?
    
    public init() {
        saveDate = UserDefaults.standard.string(forKey: "saveDate") ?? ""
        saveDateHour = UserDefaults.standard.string(forKey: "saveDateHour") ?? ""
        selectedChangeTimeView = UserDefaults.standard.bool(forKey: "selectedChangeTimeView")
        randomNickName = UserDefaults.standard.string(forKey: "randomNickName") ?? ""
        userPrefId = UserDefaults.standard.integer(forKey: "userPrefId")
        
    }
    
    
    
    let profileViewListArray: [ProfileViewComponentModel] = [
        ProfileViewComponentModel(isDevider: true, imageName: "notificationImage", content: "명언 알림 메시지", detail: "당신을 위한 명언을 배송해드릴게요."),
        ProfileViewComponentModel(isDevider: true, imageName: "reviewImage", content: "앱 리뷰 작성", detail: "서비스에 대한 평가를 남겨주세요."),
        ProfileViewComponentModel(isDevider: true, imageName: "bugImage", content: "버그 신고 및 의견 공유", detail: "더 좋은 서비스를 함께 만들어가요."),
        ProfileViewComponentModel(isDevider: false, imageName: "settingImage", content: "기타 설정", detail: "각종 설정들을 관리해요."),
    ]
    
    
    //MARK: -  프로필 취향 조회
    private func profileUserPrefToViewModel(_ list: ProfileUserPrefModel) {
        self.profileUserPrefModel = list
    }
    
    
    public func profileUserPrefRequset(userid: String, completion: @escaping (ProfileUserPrefModel) -> Void) async {
        if let cancellable = profileUserPrefCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<MyPageService>(plugins: [MoyaLoggingPlugin()])
        profileUserPrefCancellable = provider.requestWithProgressPublisher(.myPageUsePref(userId: userid))
            .compactMap{$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: ProfileUserPrefModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.network("네트워크 에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if let status = model.status {
                    if status == NetworkCode.success.status {
                        self?.profileUserPrefToViewModel(model)
                        Log.network("회원정보 조회", model)
                        self?.userPrefId = model.data?.userPrefID ?? .zero
                        completion(model)
                    } else {
                        self?.profileUserPrefToViewModel(model)
                        Log.network("회원정보 조회", model)
                    }
                }
            })
                
    }
    
    
    //MARK: - 취향 수정
    private func profileUserPrefEditToViewModel(_ list: BaseModel) {
        self.baseModel = list
    }
    
    
    public func profileUserPrefEditPUT(
        userPrefId: Int,
        flavors: [String],
        sources: [String],
        successCompletion: @escaping () -> Void
    ) async {
        if let cancellable = changeUserPrefEditCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<MyPageService>(plugins: [MoyaLoggingPlugin()])
        changeUserPrefEditCancellable = provider.requestWithProgressPublisher(.myPageEditUserPref(userPrefId: "\(userPrefId)", flavors: flavors, sources: sources))
            .compactMap{$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: BaseModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.network("네트워크 에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if let status = model.status {
                    if status == model.status {
                        self?.profileUserPrefEditToViewModel(model)
                        Log.network("취향 수정 ", model)
                        successCompletion()
                    } else {
                        self?.profileUserPrefEditToViewModel(model)
                        Log.network("취향 수정 ", model)
                    }
                }
            })
    }
    
    //MARK: -  회원탈퇴
    
    public func withDrawToViewModel(_ list: WithDrawModel) {
        self.withDrawModel = list
    }
    
    public func withDrawPost(
        userID: String,
        reason: String,
        successCompletion: @escaping () -> Void
    ) async {
        if let cancellable = withDrawCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<AuthorizationService>(plugins: [MoyaLoggingPlugin()])
        withDrawCancellable = provider.requestWithProgressPublisher(.withDraw(userId: userID, reason: reason))
            .compactMap{$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: WithDrawModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                    
                case .failure(let error):
                    Log.network("네트워크 에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if let status = model.status {
                    if status == NetworkCode.success.status {
                        self?.withDrawToViewModel(model)
                        Log.network("회원탈퇴 성공", model)
                        successCompletion()
                    } else {
                        self?.withDrawToViewModel(model)
                        Log.network("회원탈퇴 실패", model)
                    }
                }
            })
        
    }
    
    public func changeNickName(
        userID: String,
        nickName: String,
        completion: @escaping () -> Void
    ) async {
        if let cancellable = changeNickNameCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<AuthorizationService>(plugins: [MoyaLoggingPlugin()])
        changeNickNameCancellable = provider.requestWithProgressPublisher(.changeUserInfo(userId: userID, nickname: nickName))
            .compactMap{$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: WithDrawModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                    
                case .failure(let error):
                    Log.network("네트워크 에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if let status = model.status {
                    if status == NetworkCode.success.status {
                        self?.withDrawToViewModel(model)
                        Log.network("이름 변경 성공", model)
                        completion()
                    } else {
                        self?.withDrawToViewModel(model)
                        Log.network("이름 변경 성공", model)
                    }
                }
            })
    }
    
    //MARK: - 닉네임 유효성 검증
    public func allValidateNikname(nicknameValidate: Bool, duplicateValidate: Bool){
        if !nicknameValidate {
            self.nicknameValidation = .invalid
        } else if !duplicateValidate {
            self.nicknameValidation = .duplicate
        } else {
            self.nicknameValidation = .valid
        }
        
        self.changeValidationText = CheckRegister.generateValidationText(validation: self.nicknameValidation)
        self.changeValidationColor = CheckRegister.generateValidationColor(validation: self.nicknameValidation)
        self.changeValidationImageName = CheckRegister.generateValidationImage(validation: self.nicknameValidation)
    }
    
    public func validateNickname(nickname: String) -> Bool {
        if nickname.count < 1 || nickname.count > 12 { return false }
        for character in nickname {
            if !self.unicodeArray.contains(character) { return false }
        }
        return true
    }
    
    public func changeImage(randomNickName: String) {
        switch randomNickName {
        case "바삭바삭 명언제과":
            changeNickImage = "crunchyNickname"
        case "포근포근 명언베이커리":
            changeNickImage = "cozyNickName"
        case "퐁실퐁실 명언빵집":
            changeNickImage = "pomsilNickname"
        case "모락모락 명언빵공장":
            changeNickImage = "morakNickname"
        case "보들보들 명언제빵소":
            changeNickImage = "softNickName"
            
        default:
            break
        }
    }
    
    public func commCodeToViewModel(_ list: CommonCdModel) {
        self.commonCodeModel = list
    }
    
    public func randomNameRequest(commCdTpCd: CommonType) async {
        if let cancellable = randomNameCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<SearchService>(plugins: [MoyaLoggingPlugin()])
        randomNameCancellable = provider.requestWithProgressPublisher(.searchCommCode(commCdTpCd: commCdTpCd.description))
            .compactMap { $0.response?.data }
            .receive(on: DispatchQueue.main)
            .decode(type: CommonCdModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.network("네트워크에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.success.status {
                    self?.commCodeToViewModel(model)
                    
                    if let randomCommNm = model.data?.commCds.randomElement()?.commNm {
                        self?.randomNickName = randomCommNm
                        Log.network("랜덤 이름", randomCommNm)
                    }
                } else {
                    self?.commCodeToViewModel(model)
                    Log.network("유저 코드", model)
                }
            })
    }
}


