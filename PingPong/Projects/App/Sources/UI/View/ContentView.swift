//
//  ContentView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI
import LinkNavigator

struct ContentView: View {
    @State var selectedTab: Tab = .home
    @StateObject var viewModel = MainTabViewModel()
    var body: some View {
        VStack {
               Spacer()
               switch selectedTab {
               case .home:
                   findView(for: .home)
               case .safari:
                   findView(for: .safari)
               case .archivebox:
                   findView(for: .archivebox)
               case .person:
                   findView(for: .person)
               }
               Spacer()
               MainTabView(selectedTab: $selectedTab)
           }
    }
    @ViewBuilder
       private func findView(for tab: Tab) -> some View {
           if let customTab = viewModel.customTabs.first(where: { $0.tab == tab }) {
               customTab.view
           } else {
               EmptyView()
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

