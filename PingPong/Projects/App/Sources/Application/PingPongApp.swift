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
import Profile
import DesignSystem
import Model
import API

@available(iOS 16.4, *)
@main
struct PingPongProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var showlanch: Bool = true
    @StateObject var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    @StateObject var commonViewViewModel: CommonViewViewModel = CommonViewViewModel()
    
    @StateObject var sheetManager = SheetManager()
    var body: some Scene {
        WindowGroup {
                ZStack {
                    if commonViewViewModel.isLoginCheck {
                        CoreView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.isFirstUserPOPUP)
                            .environmentObject(authViewModel)
                            .environmentObject(sheetManager)
                            .navigationBarHidden(true)
                            .onAppear {
                                if commonViewViewModel.isLoginCheck {
                                    authViewModel.getRefreshToken()
                                } else {
                                    APIHeaderManger.shared.firebaseUid = ""
                                }
                            }
                        
                    } else if commonViewViewModel.isExploreApp {
                        CoreView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.isFirstUserPOPUP)
                            .environmentObject(authViewModel)
                            .environmentObject(sheetManager)
                            .navigationBarHidden(true)
                            .onAppear {
                                if commonViewViewModel.isLoginCheck {
                                    
                                    authViewModel.getRefreshToken()
                                } else {
                                    APIHeaderManger.shared.firebaseUid = ""
                                }
                            }
                    }
                    
                    
                    else {
                        LoginView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                            .onAppear {
                                if commonViewViewModel.isLoginCheck {
                                    authViewModel.getRefreshToken()
                                } else {
                                    APIHeaderManger.shared.firebaseUid = ""
                                }
                            }
                    }
                    
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


