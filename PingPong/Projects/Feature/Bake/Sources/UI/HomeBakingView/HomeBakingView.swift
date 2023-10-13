//
//  HomeBakingView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import SDWebImageSwiftUI
import SwiftUI

public struct HomeBakingView: View {
    @StateObject private var appState: AppState
    @StateObject private var viewModel: CommonViewViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var backAction: () -> Void
    
    public init(viewModel: CommonViewViewModel, appState: AppState, backAction: @escaping () -> Void) {
        self._appState = StateObject(wrappedValue: appState)
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backAction = backAction
    }
    
    public var body: some View {
            VStack {
                HomeBakingViewHeaderTitle()
                
                Spacer()
                
                AnimatedImage(name: "startViewGIF.gif", isAnimating: .constant(true))
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Spacer()
                startButtonView()
                    .padding(.bottom, 30)
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $appState.isStartBake) {
                ChoiceBreadView(viewModel: self.viewModel, appState: self.appState, backAction: {
                backAction()
                    
                })
            }
    }
    
    @ViewBuilder
    private func HomeBakingViewHeaderTitle() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.1)
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text("어서오세요,")
                Spacer()
            }
                
            HStack(alignment: .center, spacing: 0) {
                Text("오늘의 명언을 구워보세요")
                    
                Spacer()
            }
        }
        .pretendardFont(family: .SemiBold, size: 24)
        .foregroundColor(.basicGray9)
        .padding(.horizontal, 20)
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text("지금, 당신의 상황에 맞는")
                Spacer()
            }
            HStack(alignment: .center, spacing: 0) {
                Text("명언을 추천해드릴게요.")
                Spacer()
            }
        }
        .pretendardFont(family: .Medium, size: 18)
        .foregroundColor(.basicGray6)
        .padding(20)
    }
    
    @ViewBuilder
    private func startButtonView() -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.primaryOrange)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("시작하기")
                        .foregroundColor(.basicWhite)
                        .onTapGesture {
                            appState.isStartBake.toggle()
                        }
                }
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.clear)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("다음에 할게요")
                        .foregroundColor(.basicGray5)
                        .font(.system(size: 16))
                }
                .onTapGesture {
                    backAction()
                }
        }   .pretendardFont(family: .SemiBold, size: 16)
    }
}