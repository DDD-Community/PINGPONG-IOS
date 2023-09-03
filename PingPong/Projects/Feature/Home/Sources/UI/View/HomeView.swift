//
//  HomeView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI


public struct HomeView: View {
    
    public init() {
//        self.i0 = i0
    }
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("test")
            Text("test")
           
            
        }
        .padding()
    }
}

public struct HomeView_Previews: PreviewProvider {
    public static var previews: some View {
        HomeView()
    }
}
