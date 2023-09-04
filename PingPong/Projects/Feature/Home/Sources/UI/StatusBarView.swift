//
//  StatusBarView.swift
//  pingpongFrame
//
//  Created by Byeon jinha on 2023/07/02.
//

import SwiftUI
import DesignSystem

struct StatusBarView: View {
    
    var goProfileSettingView: () -> Void = {}
    
    var body: some View {
//        Spacer()
//            .frame(height: 13)
        
        HStack{
            Text("명언제과점")
                .dNFBitBit(size: 26)
                .frame(height: 40)
            
            Spacer()
            
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    goProfileSettingView()
                }
        }
        .foregroundColor(.primaryOrangeDark)
    }
}
