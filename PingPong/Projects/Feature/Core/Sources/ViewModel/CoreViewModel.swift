//
//  HomeViewModelTest.swift
//  PingPongTests
//
//  Created by 서원지 on 2023/06/11.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import SwiftUI
import Combine
import Home
import Search
import Archive
import Model

public class CoreViewModel: ObservableObject {
    
    @AppStorage("isFirstUserPOPUP") public var isFirstUserPOPUP: Bool = false
    var commonViewViewModel: CommonViewViewModel = CommonViewViewModel()
    @Published var selectedTab: Tab = .home
    @Published var customTabs: [CustomTab] = []
    public init() {
        setupCustomTabs(homePosts: [])
        isFirstUserPOPUP = UserDefaults.standard.bool(forKey: "isFirstUserPOPUP")
    }
    
    private func setupCustomTabs(homePosts: [Post]) {
        let homeView = HomeView(viewModel: commonViewViewModel)
        let exploreView = ExploreView(viewModel: commonViewViewModel)
        let arhiveView = ArchiveView(viewModel: commonViewViewModel)
        let customTabHome = CustomTab(name: "홈", imageName: "homeTap", tab: .home, view: AnyView(homeView), isOn: false)
        let customTabSafari = CustomTab(name: "탐색", imageName: "exploreTap", tab: .explore, view: AnyView(exploreView), isOn: false)
        let customTabArchive = CustomTab(name: "보관함", imageName: "archiveTap", tab: .archive, view: AnyView(arhiveView), isOn: false)
        
        customTabs = [customTabHome, customTabSafari, customTabArchive]
    }
    
}

