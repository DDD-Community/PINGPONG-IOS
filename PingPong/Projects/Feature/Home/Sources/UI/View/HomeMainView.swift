//
//  HomeMainView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI

public struct HomeMainView: View {
    
    public init() { }
    @EnvironmentObject var sheetManager: SheetManager
    @StateObject var viewModel: HomeViewViewModel = HomeViewViewModel()
    
    public var body: some View {
        NavigationStack {
            ZStack{
                Color.basicGray1BG
                ZStack {
                    VStack {
                        StatusBarView()
                            .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing:20))
                        Spacer()
                    }
                    VStack {
                        switch viewModel.selectedTab {
                        case .home:
                            findView(for: .home)
                        case .safari:
                            findView(for: .safari)
                        case .archivebox:
                            findView(for: .archivebox)
                        }
                        Spacer()
                    }
                    .padding(.top, UIScreen.screenHeight * 0.1)
                    VStack {
                        Spacer()
                        MainTabView(selectedTab: $viewModel.selectedTab)
                            .frame(height: UIScreen.main.bounds.height * 0.12)
                    }
                    Rectangle()
                        .foregroundColor(sheetManager.isPopup ? Color.black.opacity(0.6) : .clear)
                    
                }
                //                  .popup(with: sheetManager, searchViewButtonInfoArray: $viewModel.searchViewButtonInfoArray, selectedIdx: viewModel.selectedIdx)
            }.ignoresSafeArea()
        }
        .onAppear {
                            for family: String in UIFont.familyNames {
                                print(family)
                                for names : String in
                                        UIFont.fontNames(forFamilyName: family) {
                                    print("===\(names)")
                                }
                            }
                            print(UIScreen.main.bounds.size)
                        
                    }
    }
    
    @ViewBuilder
    private func findView(for tab: Tab) -> some View {
        if let customTab = viewModel.customTabs.first(where: { $0.tab == tab }) {
            customTab.view
        }
    }
}
