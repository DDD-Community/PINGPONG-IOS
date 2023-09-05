//
//  HomeApp.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import Home
import SwiftUI

@main
struct HomeApp: App {
    @StateObject var sheetManager = SheetManager()
    @StateObject var viewModel: HomeViewViewModel = HomeViewViewModel()
    var body: some Scene {
        WindowGroup {
            HomeMainView(viewModel: viewModel, isFistUserPOPUP: .constant(false))
                .environmentObject(sheetManager)
        }
    }
}
