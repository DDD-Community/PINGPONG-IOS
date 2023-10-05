//
//  Extension+CommonViewViewModel.swift
//  PingPong
//
//  Created by 서원지 on 10/5/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Model
import Common
import Home
import Authorization
import Archive
import Search
import SwiftUI


extension CommonViewViewModel {
     func setupCustomTabs() {
        let homeView = HomeView(viewModel: self)
        let exploreView = ExploreView(viewModel: self)
        let arhiveView = ArchiveView(viewModel: self)
        let customTabHome = CustomTab(name: "홈", imageName: "homeTap", tab: .home, view: AnyView(homeView), isOn: false)
        let customTabSafari = CustomTab(name: "탐색", imageName: "exploreTap", tab: .explore, view: AnyView(exploreView), isOn: false)
        let customTabArchive = CustomTab(name: "보관함", imageName: "archiveTap", tab: .archive, view: AnyView(arhiveView), isOn: false)
        customTabs = [customTabHome, customTabSafari, customTabArchive]
    }
}


