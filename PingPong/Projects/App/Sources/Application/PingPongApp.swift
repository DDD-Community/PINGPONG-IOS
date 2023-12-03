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
            NavigationStack(path: $commonViewViewModel.viewPath) {
                ZStack {
                    if authViewModel.isLoginCheck {
                        CoreView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.isFirstUserPOPUP)
                            .environmentObject(authViewModel)
                            .environmentObject(sheetManager)
                            .navigationBarHidden(true)
                            .onAppear {
                                authViewModel.getRefreshToken()
                            }
                        
                    } else {
                        LoginView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                            .onAppear {
                                authViewModel.getRefreshToken()
                            }
                    }
                    
                    ZStack {
                        if showlanch {
                            LaunchView(showLanchView: $showlanch)
                        }
                    }
                }
                .navigationDestination(for: ViewState.self) { state in
                    switch state {
                        
                    case .isStartLogin:
                        OnBoardingLoginView(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                    case .isStartEnter:
                        OnBoardingView(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                    case .isStartServiceAgreement:
                        ServiceUseAgreementView(path: $commonViewViewModel.viewPath)
                            .environmentObject(viewModel)
                    case .isServiceAgreeComplete:
                        LoginSettingView(viewModel: self.viewModel, commonViewViewModel: self.commonViewViewModel)
                    case .isNickNameComplete:
                        LoginJobSettingView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                     case .isJobSettingComplete:
                        CompleteLoginView(viewModel: self.viewModel, commonViewModel: self.commonViewViewModel)
                    case .isCompleteLogin:
                        FavoriteWiseChooseView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                    case .isStartChoiceFavorite:
                        SelectCategoryView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                    case .isSelectedCategory:
                        SelectCharacterView(viewModel: self.viewModel, commonViewModel: commonViewViewModel)
                    case .isSelectedCharacter:
                        OnBoardingPushView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)

                    case .isCompleteOnboarding:
                        CompletOnBoardingView(viewModel: viewModel, commonViewViewModel: commonViewViewModel)
                            .environmentObject(authViewModel)
                    case .isDeniedNoti:
                        RecomandPushNotificationView(viewModel: self.viewModel, commonViewViewModel: commonViewViewModel)
                    case .isLoginned:
                        CoreView(viewModel: commonViewViewModel, isFistUserPOPUP: $commonViewViewModel.firstUserPOPUP)
                            .environmentObject(authViewModel)
                            .environmentObject(sheetManager)
                    }
                }
                .onAppear {
                    commonViewViewModel.setupCustomTabs()
                }
            }
        }
        
    }
}


