//
//  SnapCarousel.swift
//  HomeApp
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct SnapCarousel<Content: View, T: Identifiable> : View{
    @Binding var isOn : [Bool]
    var content: (T) -> Content
    var list: [T]
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    public func update(index: Int) {
        withAnimation {
            isOn[index] = true
            if index > 0 {
                isOn[index - 1] = false
            }
            if index < (list.count - 1) {
                isOn[index + 1] = false
            }
        }
    }
    
    init(spacing : CGFloat = UIScreen.screenWidth * 0.5, trailingSpace : CGFloat = UIScreen.screenWidth * 0.1, index : Binding<Int> , items:[T], isOn: Binding<[Bool]>, @ViewBuilder content: @escaping (T)-> Content ){
        self._isOn = isOn
        self.list = items
        self.spacing
            = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex : Int = 0
    
    var body : some View{
        GeometryReader{proxy in
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2 ) - spacing
            
            HStack(spacing: spacing){
                ForEach(list){item in
                    content(item)
                        .frame(width : proxy.size.width - trailingSpace, height: UIScreen.screenHeight )
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (adjustMentWidth) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: {value ,out, _ in
                        out  = value.translation.width
                    })
                    .onEnded({value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        currentIndex = max(min(currentIndex + Int(roundIndex),list.count - 1 ), 0 )
                        currentIndex = index
                        update(index : currentIndex)
                        
                    })
                    .onChanged({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        index = max(min(currentIndex + Int(roundIndex),list.count - 1 ), 0 )
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0 )
    }
}

