//
//  HomeView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI

public struct HomeView: View {
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

public struct HomeView_Previews: PreviewProvider {
    public static var previews: some View {
        HomeView()
    }
}
