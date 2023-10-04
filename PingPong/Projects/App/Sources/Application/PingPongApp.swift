//
//  PingPongProjectApp.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import Model
import Common
import SwiftUI
import Core
import OnBoarding
import Home
import Authorization
import Archive
import Search

@main
struct PingPongProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sheetManager = SheetManager()
    @State var showlanch: Bool = true
    @StateObject var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    @StateObject var commonViewViewModel: CommonViewViewModel = CommonViewViewModel()
    private func setupCustomTabs() {
        let homeView = HomeView(viewModel: commonViewViewModel)
        let exploreView = ExploreView(viewModel: commonViewViewModel)
        let arhiveView = ArchiveView(viewModel: commonViewViewModel)
        let customTabHome = CustomTab(name: "홈", imageName: "homeTap", tab: .home, view: AnyView(homeView), isOn: false)
        let customTabSafari = CustomTab(name: "탐색", imageName: "exploreTap", tab: .explore, view: AnyView(exploreView), isOn: false)
        let customTabArchive = CustomTab(name: "보관함", imageName: "archiveTap", tab: .archive, view: AnyView(arhiveView), isOn: false)
        commonViewViewModel.customTabs = [customTabHome, customTabSafari, customTabArchive]
    }
    var body: some Scene {
        WindowGroup {
           
            ZStack {
                if viewModel.isLogin {
                    HomeMainView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.isFirstUserPOPUP)
                        .environmentObject(sheetManager)
                    
                } else {
                    OnBoardingView()
                }
                
//                HomeMainView()
//                    .environmentObject(sheetManager)
                
//
                

                ZStack {
                    if showlanch {
                        LaunchView(showLanchView: $showlanch)
                    }
                }
            }
            .onAppear {
                setupCustomTabs()
            }
        }
        
    }
}


