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
    @Environment(\.presentationMode) var presentationMode
    @Binding var isFistUserPOPUP: Bool
    
    @StateObject private var viewModel: HomeViewViewModel
    
    public init(viewModel: HomeViewViewModel, isFistUserPOPUP: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._isFistUserPOPUP = isFistUserPOPUP
    }
    
    public var body: some View {
            ZStack{
                Color.basicGray1BG
                ZStack {
                    VStack {
                        if self.viewModel.selectedTab == .home {
                            navigationTopHeaderView()
                                .padding(EdgeInsets(top: 60, leading: 0, bottom: 20, trailing: 0))
                        }
                        selectTabView()
                    }
                    mainTabBar()
                }
                .modal(sheetManager: sheetManager, viewModel: viewModel)
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
                        .backgroundColor(.basicBlackDimmed)
                }
                
                .fullScreenCover(isPresented: $appState.goToProfileSettingView) {
                    ProfileView {
                        appState.goToProfileSettingView = false
                    }
                    .transition(.slide)
                }
            }
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
            .frame(height: 40)
            .findNavigator(isPresented: $appState.goToProfileSettingView)
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
            .foregroundColor(sheetManager.isPopup ? Color.basicBlackDimmed : .clear)
        ZStack {
            Rectangle()
                .foregroundColor(viewModel.isShowDetailView ? Color.basicBlackDimmed : .clear)
                .onTapGesture {
                    viewModel.isShowDetailView.toggle()
                }
            if viewModel.isShowDetailView {
                FamousSayingDetailView(viewModel: self.viewModel)
            }
        }
    }
    
    
}

extension View {
    func modal(sheetManager: SheetManager, viewModel: HomeViewViewModel) -> some View {
        self.modifier(ModalViewModifier(viewModel: viewModel, sheetManager: sheetManager))
    }
}
