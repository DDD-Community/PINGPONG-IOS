//
//  StatusBarView.swift
//  pingpongFrame
//
//  Created by Byeon jinha on 2023/07/02.
//

import SwiftUI

struct StatusBarView: View {
    var body: some View {
        
        HStack{
            Text("명언제과점")
                .font(.custom("DNF Bit Bit TTF", size: 26))
                .frame(height: 40)
            Spacer()
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 24, height: 24)
        }
        .foregroundColor(.primaryOrangeDark)
    }
}
