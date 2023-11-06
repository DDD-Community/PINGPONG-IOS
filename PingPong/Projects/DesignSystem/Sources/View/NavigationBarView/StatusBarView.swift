//
//  StatusBarView.swift
//  pingpongFrame
//
//  Created by Byeon jinha on 2023/07/02.
//

import DesignSystem
import SwiftUI


public struct StatusBarView: View {
    public var goProfileSettingView: () -> Void = {}
    @Binding var isGoToProfileView: Bool
    public init(goProfileSettingView: @escaping () -> Void, isGoToProfileView: Binding<Bool>) {
        self.goProfileSettingView = goProfileSettingView
        self._isGoToProfileView = isGoToProfileView
    }
    
    public var body: some View {
        HStack{
            Image(assetName: "mainHomeLogo")
                .resizable()
                .frame(width: 36, height: 36)
            Text("명언제과점")
                .gmarketSans(family: .Bold, size: 22)
                .frame(height: 40)
                .foregroundColor(.primaryOrange)
            Spacer()
            
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.primaryOrangeDark)
                .onTapGesture {
                    goProfileSettingView()
                    self.isGoToProfileView = true
                }
        }
        .padding(.horizontal, 20)
        
    }
}
