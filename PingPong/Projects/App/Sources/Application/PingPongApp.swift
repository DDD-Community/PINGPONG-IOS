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
    @State var showlanch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                OnBoardingView()
                
                ZStack {
                    if showlanch {
                        LaunchView(showLanchView: $showlanch)
                    }
                }
            }
        }
        
    }
}
