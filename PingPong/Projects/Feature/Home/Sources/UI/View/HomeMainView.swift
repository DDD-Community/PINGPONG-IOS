//
//  HomeMainView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI
import DesignSystem
import PopupView

public struct HomeMainView: View {
    @EnvironmentObject var sheetManager: SheetManager
    @StateObject var viewModel: HomeViewViewModel = HomeViewViewModel()
//    @Binding var isFistUserPOPUP: Bool
    
    public init() {
//        self._isFistUserPOPUP = isFistUserPOPUP
    }
    
    
    
    public var body: some View {
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
//            .popup(isPresented: $isFistUserPOPUP) {
//                CustomPOPUP(image: .empty, title: "좌우를 넘기며", title1: "명언을 확인해보세요", subTitle: "", useGif: true, confirmAction: {
//                    isFistUserPOPUP = false
//                    
////                    viewModel.isFirstUserPOPUP = true
//                })
//            } customize: { popup in
//                popup
//                    .type(.default)
//                    .position(.bottom)
//                    .animation(.easeIn)
//                    .closeOnTap(true)
//                    .closeOnTapOutside(true)
//            }

            
            //                  .popup(with: sheetManager, searchViewButtonInfoArray: $viewModel.searchViewButtonInfoArray, selectedIdx: viewModel.selectedIdx)
        }
        .ignoresSafeArea()
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
