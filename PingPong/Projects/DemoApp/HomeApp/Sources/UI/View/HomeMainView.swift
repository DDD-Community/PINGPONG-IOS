//
//  HomeMainView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI
import Inject


public struct HomeMainView: View {
    @ObservedObject private var i0 = Inject.observer
    
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
            
           
            
        }
        .padding()
        .enableInjection()
    }
}

public struct HomeMainView_Previews: PreviewProvider {
    public static var previews: some View {
        HomeMainView()
    }
}
