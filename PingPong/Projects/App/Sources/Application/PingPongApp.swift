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
    var body: some Scene {
        WindowGroup {
           
            ZStack {
                if viewModel.isLoginCheck {
                    CoreView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.isFirstUserPOPUP)
                        .environmentObject(sheetManager)
                        .navigationBarHidden(true)
                    
                } else {
                    OnBoardingView(viewModel: self.viewModel)
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
                commonViewViewModel.setupCustomTabs()
            }
        }
        
    }
}


