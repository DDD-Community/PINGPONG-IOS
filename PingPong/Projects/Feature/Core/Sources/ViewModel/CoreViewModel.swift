//
//  HomeViewModelTest.swift
//  PingPongTests
//
//  Created by 서원지 on 2023/06/11.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Combine
import Home
import Search
import Archive
import Model

public class CoreViewModel: ObservableObject {
    
    @AppStorage("isFirstUserPOPUP") public var isFirstUserPOPUP: Bool = false
    var homeViewModel: HomeViewViewModel = HomeViewViewModel()
    @Published var selectedTab: Tab = .home
    @Published var customTabs: [CustomTab] = []
    public init() {
        setupCustomTabs(homePosts: [])
        isFirstUserPOPUP = UserDefaults.standard.bool(forKey: "isFirstUserPOPUP")
    }
    
    private func setupCustomTabs(homePosts: [Post]) {
        let homeView = HomeView(viewModel: homeViewModel)
        let exploreView = ExploreView(viewModel: homeViewModel)
        let arhiveView = ArchiveView(viewModel: homeViewModel)
        let customTabHome = CustomTab(name: "홈", imageName: "homeTap", tab: .home, view: AnyView(homeView), isOn: false)
        let customTabSafari = CustomTab(name: "탐색", imageName: "exploreTap", tab: .explore, view: AnyView(exploreView), isOn: false)
        let customTabArchive = CustomTab(name: "보관함", imageName: "archiveTap", tab: .archive, view: AnyView(arhiveView), isOn: false)
        
        customTabs = [customTabHome, customTabSafari, customTabArchive]
    }
    
}

