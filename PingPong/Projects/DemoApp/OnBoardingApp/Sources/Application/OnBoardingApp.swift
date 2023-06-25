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
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                OnBoardingView()
                
                ZStack {
                    if showLanch {
                        LanchView(showLanchView: $showLanch)
                    }
                }
            }
        }
    }
}
