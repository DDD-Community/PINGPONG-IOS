//
//  HomeMainView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import Common
import SwiftUI
import DesignSystem
import PopupView
import Archive
import Authorization
import Model
import Home
import Profile

public struct CoreView: View {
    @EnvironmentObject var sheetManager: SheetManager
    @StateObject var appState: AppState = AppState()
    @Environment(\.presentationMode) var presentationMode
    @Binding var isFistUserPOPUP: Bool
    @EnvironmentObject var authViewModel: AuthorizationViewModel
    @StateObject var viewModel: CommonViewViewModel
    
    public init(viewModel: CommonViewViewModel, isFistUserPOPUP: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._isFistUserPOPUP = isFistUserPOPUP
    }
    
    public var body: some View {
        NavigationStack {
            ZStack{
                Color.basicGray1BG
                ZStack {
                    VStack {
                        if self.viewModel.selectedTab == .home {
                            navigationTopHeaderView()
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        }
                        selectTabView()
                    }
                    
                    mainTabBar()
                }
                .modal(with: sheetManager, viewModel: viewModel)
                .onAppear {
                    if viewModel.isFirstUserPOPUP {
                        isFistUserPOPUP = true
                    } else {
                        isFistUserPOPUP = false
                        
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
                
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            self.viewModel.setupCustomTabs()
        }
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
            }, isGoToProfileView: $appState.isGoToProfileView)
            .frame(height: 40)
            .findNavigator(isPresented: $appState.goToProfileSettingView)
        }  .navigationDestination(isPresented: $appState.isGoToProfileView) {
            ProfileView(viewModel: viewModel, appState: appState, backAction: {
                appState.goToBackingView = false
            })
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
                .frame(height: UIScreen.main.bounds.height == 667 ? UIScreen.main.bounds.height * 0.13 : UIScreen.main.bounds.height * 0.11)
                .padding(.bottom,  UIScreen.main.bounds.height == 667 ? -UIScreen.main.bounds.height * 0.04 : -UIScreen.main.bounds.height * 0.05)
        }
        Rectangle()
            .foregroundColor(sheetManager.isPopup ? Color.basicBlackDimmed : .clear)
        ZStack {
            Rectangle()
                .foregroundColor(viewModel.isShowDetailView ? Color.basicBlackDimmed : .clear)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.isShowDetailView.toggle()
                }
            if viewModel.isShowDetailView {
                    FamousSayingDetailView(viewModel: self.viewModel)
            }
        }
    }
    
    
}

