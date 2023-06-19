//
//  MainTabViewModel.swift
//  PingPong
//
//  Created by Byeon jinha on 2023/06/19.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

class MainTabViewModel: ObservableObject {
    @Published var customTabs: [CustomTab] = [
        CustomTab(name: "홈", image: "house.fill", tab: .home, view: AnyView(CardView())),
        CustomTab(name: "탐색", image: "safari.fill", tab: .safari, view: AnyView(SafariView())),
        CustomTab(name: "보관", image: "archivebox.fill", tab: .archivebox, view: AnyView(CardView())),
        CustomTab(name: "설정", image: "person.fill", tab: .person, view: AnyView(CardView()))
        ]
}

enum Tab {
    case home
    case safari
    case archivebox
    case person
}

struct CustomTab {
    var name: String
    var image: String
    var tab: Tab
    var view: AnyView
}
