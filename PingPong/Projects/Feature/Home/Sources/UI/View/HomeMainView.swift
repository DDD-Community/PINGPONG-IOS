//
//  HomeMainView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI
import DesignSystem
import PopupView
import Profile

public struct HomeMainView: View {
    @EnvironmentObject var sheetManager: SheetManager
    
    @StateObject var appState: HomeAppState = HomeAppState()
    @Environment(\.presentationMode) var  presentationMode
    @Binding var isFistUserPOPUP: Bool
    
    @StateObject private var viewModel: HomeViewViewModel
    
    public init(viewModel: HomeViewViewModel, isFistUserPOPUP: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._isFistUserPOPUP = isFistUserPOPUP
    }
    
    public var body: some View {
        NavigationStack(root: {
            ZStack{
                Color.basicGray1BG
                ZStack {
                    VStack {
                        if self.viewModel.selectedTab == .home {
                            navigationTopHeaderView()
                                .frame(height: UIScreen.screenHeight * 0.06)
                        }
                        selectTabView()
                    }
                    mainTabBar()
                }
                .modal(with: sheetManager, searchViewButtonInfoArray: $viewModel.searchViewButtonInfoArray)
                .onAppear {
                    if viewModel.isFirstUserPOPUP {
                        isFistUserPOPUP = false
                    } else {
                        isFistUserPOPUP = true
                    }
                }
                .popup(isPresented: $isFistUserPOPUP) {
                    CustomPOPUP(image: .empty, title: "좌우를 넘기며", title1: "명언을 확인해보세요", subTitle: "", useGif: true, confirmAction: {
                        isFistUserPOPUP = false
                        viewModel.isFirstUserPOPUP = true
                    })
                } customize: { popup in
                    popup
                        .type(.default)
                        .position(.bottom)
                        .animation(.easeIn)
                        .closeOnTap(true)
                        .closeOnTapOutside(true)
                        .backgroundColor(Color.basicGray8.opacity(0.4))
                }
                
                .fullScreenCover(isPresented: $appState.goToProfileSettingView) {
                    ProfileView {
                        appState.goToProfileSettingView = false
                    }
                    .transition(.slide)
                }
            }
        })
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func findView(for tab: Tab) -> some View {
        if let customTab = viewModel.customTabs.first(where: { $0.tab == tab }) {
            customTab.view
        }
    }
    
    @ViewBuilder
    private func navigationTopHeaderView() -> some View {
        VStack {
            StatusBarView(goProfileSettingView: {
                appState.goToProfileSettingView.toggle()
            })
            .findNavigator(isPresented: $appState.goToProfileSettingView)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing:20))
            
            Spacer()
        }
    }
    
    
    @ViewBuilder
    private func selectTabView() -> some View {
        VStack {
            
            switch viewModel.selectedTab {
            case .home:
                findView(for: .home)
            case .explore:
                findView(for: .explore)
            case .archive:
                findView(for: .archive)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func mainTabBar() -> some View {
        VStack {
            Spacer()
            MainTabView(viewModel: self.viewModel, selectedTab: $viewModel.selectedTab)
                .frame(height: UIScreen.main.bounds.height * 0.15)
                .padding(.bottom, -UIScreen.main.bounds.height * 0.05)
        }
        Rectangle()
            .foregroundColor(sheetManager.isPopup ? Color.black.opacity(0.6) : .clear)
    }
}

extension View {
    func modal(with sheetManager: SheetManager, searchViewButtonInfoArray: Binding<[SearchViewButtonInfo]>, selectedIdx: Binding<Int>) -> some View {
        self.modifier(ModalViewModifier(sheetManager: sheetManager, searchViewButtonInfoArray: searchViewButtonInfoArray))
    }
}
