//
//  ContentView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                ForEach(1...10, id: \.self) { item in
                    CardView()
                }
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
