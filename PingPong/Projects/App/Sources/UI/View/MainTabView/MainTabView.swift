//
//  MainTabView.swift
//  PingPong
//
//  Created by Byeon jinha on 2023/06/17.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @Binding var selectedTab: Tab
    @StateObject var vm = MainTabViewModel()
    
    var body: some View {
        HStack{
            ForEach(vm.customTabs.indices, id: \.self) { idx in
                VStack{
                    Button(action: {
                        selectedTab = vm.customTabs[idx].tab
                    }) {
                        VStack{
                            Circle()
                                .foregroundColor(Color.gray)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image(systemName: vm.customTabs[idx].image)
                                        .foregroundColor(.black)
                                )
                            Text(vm.customTabs[idx].name)
                                .foregroundColor(.black)
                        }
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    }
                }
            }
        }
    }
}
