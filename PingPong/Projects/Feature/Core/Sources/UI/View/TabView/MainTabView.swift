//
//  MainTabView.swift
//  pingpongFrame
//
//  Created by Byeon jinha on 2023/07/02.
//

import Common
import Model
import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel: CommonViewViewModel
    
    init(viewModel: CommonViewViewModel, selectedTab: Binding<Tab>) {
        @State var selectedIdx: Int = 0
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .shadow(color: .primaryOrangeDark.opacity(0.2), radius: 10)
            .overlay(
                VStack{
                    HStack{
                        ForEach(viewModel.customTabs.indices, id: \.self) { idx in
                            VStack{
                                Button(action: {
                                    viewModel.selectedTab = viewModel.customTabs[idx].tab
                                    viewModel.customTabs[idx].isOn = true
                                    for i in viewModel.customTabs.indices where i != idx {
                                        viewModel.customTabs[i].isOn = false
                                    }
                                    
                                }) {
                                    VStack{
                                        Image(assetName: viewModel.selectedTab == viewModel.customTabs[idx].tab ? "selected\(viewModel.customTabs[idx].imageName)": viewModel.customTabs[idx].imageName)
                                            .resizable()
                                            .frame(width: 28, height: 28)
                                        Text(viewModel.customTabs[idx].name)
                                            .pretendardFont(family: .SemiBold, size: 10)
                                            .foregroundColor(viewModel.selectedTab == viewModel.customTabs[idx].tab ? .primaryOrangeDark : .primaryOrangeMedium)
                                    }
                                    .padding(EdgeInsets(top: 10, leading: 45, bottom: 0, trailing: 45))
                                }
                            }
                        }
                    }
                    .onAppear{
                        if !viewModel.customTabs.isEmpty {
                            viewModel.customTabs[0].isOn = true
                        }
                    }
                    Spacer()
                }
            ).foregroundColor(.basicWhite)
    }
}
