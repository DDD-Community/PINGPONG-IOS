//
//  ProfileMainView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI
import Inject
import Profile

public struct ProfileMainView: View {
    @ObservedObject private var i0 = Inject.observer
    
    public init() {
    }
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("test")
            Text("test")
            Text("test")
            
           
            
        }
        .padding()
        .enableInjection()
    }
}

//public struct ProfileMainView_Previews: PreviewProvider {
//    public static var previews: some View {
//        ProfileView(backProfileViewAction: {})
//    }
//}
