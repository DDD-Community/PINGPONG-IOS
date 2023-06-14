//
//  CardView.swift
//  PingPong
//
//  Created by 서원지 on 2023/06/13.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Component

struct CardView: View {
    
    @State private var offset: CGSize = .zero
    @State private var color: Color = .gray
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.gray.opacity(0.8))
                .frame(width: UIScreen.screenWidth - 100, height: UIScreen.screenHeight / 2)
                .cornerRadius(10)
               
                .shadow(radius: 4)
            
            VStack {
                Text("이건 나는 게 아니야")
                    .bold()
                    .font(.system(size: 20))
                
                Spacer()
                    .frame(height: 10)
                
                Text("멋지게 추락하는 거지")
                    .bold()
                    .font(.system(size: 20))
                
                Spacer()
                    .frame(height: 40)
                
                Text("<토이 스토리 , 1955>")
            }
        }
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                    }
                }
        )
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
        
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
