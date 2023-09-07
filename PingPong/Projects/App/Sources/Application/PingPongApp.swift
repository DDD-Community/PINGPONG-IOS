//
//  PingPongProjectApp.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//
import SwiftUI
import Core
import OnBoarding
import Home
import Authorization

@main
struct PingPongProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sheetManager = SheetManager()
    @State var showlanch: Bool = true
    @StateObject var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    @StateObject var homeViewModel: HomeViewViewModel = HomeViewViewModel()
    
    var body: some Scene {
        WindowGroup {
           
            ZStack {
                if viewModel.isLogin {
                    HomeMainView(viewModel: self.homeViewModel, isFistUserPOPUP: $viewModel.isFirstUserPOPUP)
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
        }
        
    }
}


