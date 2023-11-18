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
    
    
    @AppStorage("selectedChangeTimeView") public var selectedChangeTimeView: Bool = false
    @AppStorage("saveDate") public var saveDate: String = ""
    @AppStorage("saveDateHour") public var saveDateHour: String = ""
    @Published public var selectTimeBottomView: Bool = false
    
    public init() {
        saveDate = UserDefaults.standard.string(forKey: "saveDate") ?? ""
        saveDateHour = UserDefaults.standard.string(forKey: "saveDateHour") ?? ""
        selectedChangeTimeView = UserDefaults.standard.bool(forKey: "selectedChangeTimeView")
    }
    
    var withDrawCancellable: AnyCancellable?
    
    @Published public var withDrawModel: WithDrawModel?
    
    
    public func withDrawToViewModel(_ list: WithDrawModel) {
        self.withDrawModel = list
    }
    
    let profileViewListArray: [ProfileViewComponentModel] = [
        ProfileViewComponentModel(isDevider: true, imageName: "notificationImage", content: "명언 알림 메시지", detail: "당신을 위한 명언을 배송해드릴게요."),
        ProfileViewComponentModel(isDevider: true, imageName: "reviewImage", content: "앱 리뷰 작성", detail: "서비스에 대한 평가를 남겨주세요."),
        ProfileViewComponentModel(isDevider: true, imageName: "bugImage", content: "버그 신고 및 의견 공유", detail: "더 좋은 서비스를 함께 만들어가요."),
        ProfileViewComponentModel(isDevider: false, imageName: "settingImage", content: "기타 설정", detail: "각종 설정들을 관리해요."),
    ]
    
    //MARK: -  회원가입
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
}

