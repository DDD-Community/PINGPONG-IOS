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
    @StateObject private var viewModel = FavoriteChoiceViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                FavoriteChoiceView(viewModel: viewModel)
            }
        }
    }
}
