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
@main
struct PingPongProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sheetManager = SheetManager()
    @State var showlanch: Bool = true
    @StateObject var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @StateObject var sheetManger = SheetManager()
    
    var body: some Scene {
        WindowGroup {
            HomeMainView()
                .environmentObject(sheetManager)
//            ZStack {
//                CompletOnBoardingView(viewModel: viewModel)
//
//                ZStack {
//                    if showlanch {
//                        LaunchView(showLanchView: $showlanch)
//                    }
//                }
//            }
        }
        
    }
}


