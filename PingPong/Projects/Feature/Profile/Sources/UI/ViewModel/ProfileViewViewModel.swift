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
    @State var selectOtherSettingItem: OhterSettingItem = .privacyPolicy
     let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    public init() {
        
    }
    
    var signupCancellable: AnyCancellable?
    
    @Published public var signupModel: SignUPModel?
    
    public func signupToViewModel(_ list: SignUPModel) {
        self.signupModel = list
    }
    
    let profileViewListArray: [ProfileViewComponentModel] = [
        ProfileViewComponentModel(isDevider: true, imageName: "notificationImage", content: "명언 알림 메시지", detail: "당신을 위한 명언을 배송해드릴게요."),
        ProfileViewComponentModel(isDevider: true, imageName: "reviewImage", content: "앱 리뷰 작성", detail: "서비스에 대한 평가를 남겨주세요."),
        ProfileViewComponentModel(isDevider: true, imageName: "bugImage", content: "버그 신고 및 의견 공유", detail: "더 좋은 서비스를 함께 만들어가요."),
        ProfileViewComponentModel(isDevider: false, imageName: "settingImage", content: "기타 설정", detail: "각종 설정들을 관리해요."),
    ]
    
    //MARK: -  회원가입
    public func signupPost(token: String, fcm: String, email: String, nickname: String, jobCd: String, signupSuccessAction: @escaping () -> Void, failSignUPAction: @escaping () -> Void) {
        if let cancellable = signupCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<AuthorizationService>(plugins: [MoyaLoggingPlugin()])
        signupCancellable = provider.requestWithProgressPublisher(.signup(token: token, fcm: fcm, email: email, nickname: nickname, jobCd: jobCd))
            .compactMap{ $0.response?.data}
            .decode(type: SignUPModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트 워크 에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                if model.status == NetworkCode.success.status {
                    self?.signupToViewModel(model)
                    print("회원가입 성공", model)
                    signupSuccessAction()
                } else {
                    self?.signupToViewModel(model)
                    print("회원가입 실패", model)
                    failSignUPAction()
                }
            })
    }
}


