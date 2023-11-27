//
//  WebViews.swift
//  DesignSystem
//
//  Created by 서원지 on 11/27/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

public struct WebViews: View {
    var url: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var loading: Bool
    
    public init(url: String, loading: Binding<Bool>) {
        self.url = url
        self._loading = loading
    }
    
    public var body: some View {
        VStack {
            if loading {
               
                Spacer()
                
                AnimatedImage(name: "bakeLoading.gif", isAnimating: .constant(true))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer()
                    
            } else {
                WebView(urlToLoad: url)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                customBackButton()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                loading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Replace 2 with desired delay
                    loading = false
                }
            }
        }
        
    }

    //MARK: - 뒤로 가기 버튼
    @ViewBuilder
    private func customBackButton() -> some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
        }

    }
}
