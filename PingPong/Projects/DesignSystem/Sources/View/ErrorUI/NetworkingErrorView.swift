//
//  NetworkingErrorView.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

public struct NetworkingErrorView: View {
    
    var refreshAction: () -> Void
    
    
    public init(refreshAction: @escaping () -> Void) {
        self.refreshAction = refreshAction
    }
    
    public var body: some View {
        VStack {
            Spacer()
            errorViewImage()
            
            errorViewText()
            
            errorButton()
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func errorViewImage() -> some View {
        VStack {
            
            Image(asset: .cloudOff)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
            
        }
    }
    
    @ViewBuilder
    private func errorViewText() -> some View {
        VStack(spacing: 8) {
            Text("인터넷 연결이")
                .pretendardFont(family: .SemiBold, size: 22)
                .foregroundColor(.black)
            
            
            Text("불안정해요")
                .pretendardFont(family: .SemiBold, size: 22)
                .foregroundColor(.black)
            
            Spacer()
                .frame(height: 8)
            
            Text("잠시후 다시 시도해보세요")
                .pretendardFont(family: .Medium, size: 16)
                .foregroundColor(.basicGray6)
            
        }
    }
    
    @ViewBuilder
    private func errorButton() -> some View {
        VStack {
            Spacer()
                .frame(height: 52)
            
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.primaryOrange)
                .frame(width: UIScreen.screenWidth/3, height: 56)
                .overlay {
                    HStack(spacing: 8) {
                        Image(asset: .refresh)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 19, height: 18)
                        
                        Text("새로고침")
                            .foregroundColor(.basicWhite)
                            .pretendardFont(family: .SemiBold, size: 16)
                    }
                }
                .onTapGesture {
                    refreshAction()
                }
        }
    }
}
