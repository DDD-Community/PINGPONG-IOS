//
//  PingPongProjectApp.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//
import SwiftUI
import Core
import OnBoarding

@main
struct PingPongProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var showlanch: Bool = true
    @StateObject var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                OnBoardingPushViiew(viewModel: viewModel)
                
                ZStack {
                    if showlanch {
                        LaunchView(showLanchView: $showlanch)
                    }
                }
            }
        }
        
    }
}
