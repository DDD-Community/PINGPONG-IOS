//
//  SearchApp.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//
import SwiftUI
import OnBoarding

@main
struct OnBoardingApp: App {
    @State private var showLanch: Bool = true
    @StateObject var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack {
                CompletOnBoardingView(viewModel: viewModel)
//                OnBoardingPushViiew()
                
//                ZStack {
//                    if showLanch {
//                        LaunchView(showLanchView: $showLanch)
//                    }
//                }
            }
        }
    }
}
