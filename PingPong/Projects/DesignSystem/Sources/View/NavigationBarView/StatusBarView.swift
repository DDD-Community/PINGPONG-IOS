//
//  StatusBarView.swift
//  pingpongFrame
//
//  Created by Byeon jinha on 2023/07/02.
//

import SwiftUI
import DesignSystem

public struct StatusBarView: View {
    public var goProfileSettingView: () -> Void = {}
    
    public init(goProfileSettingView: @escaping () -> Void) {
        self.goProfileSettingView = goProfileSettingView
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
                }
        }
        .padding(.horizontal, 20)
        
    }
}
