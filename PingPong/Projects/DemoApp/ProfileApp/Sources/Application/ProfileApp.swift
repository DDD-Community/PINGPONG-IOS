//
//  ProfileApp.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//
import SwiftUI
import Profile
//import Home

@main
struct ProfileApp: App {
    var body: some Scene {
        WindowGroup {
            ProfileView(backProfileViewAction: {})
        }
    }
}
