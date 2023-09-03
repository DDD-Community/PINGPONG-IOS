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
        
    var body: some Scene {
        WindowGroup {
            HomeMainView()
                .environmentObject(sheetManager)
        }
    }
}
