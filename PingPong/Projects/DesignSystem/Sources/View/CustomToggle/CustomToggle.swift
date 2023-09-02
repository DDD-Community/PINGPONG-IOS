//
//  CustomToggle.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI


public struct CustomToggle: ToggleStyle {
    var activeColor: Color = Color.primaryOrange
    var noActiveColor: Color
    var activeCircle: Bool
    var height: CGFloat
    var width: CGFloat

    public init(activeColor: Color, activeCircle: Bool, height: CGFloat, width: CGFloat, noActiveColor: Color) {
        self.activeColor = activeColor
        self.noActiveColor = noActiveColor
        self.activeCircle = activeCircle
        self.width = width
        self.height = height
    }

    //MARK: -  컴스텀으로 toggle 만드는 UI
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.basicWhite, style: .init(lineWidth: 2))
    //                .fill(configuration.isOn ? activeColor : Color.gray4)
                .frame(width: width, height: height)
                .background(configuration.isOn ? activeColor : noActiveColor)
                .cornerRadius(30)
                .overlay {
                    Circle()
                        .fill(activeCircle ? .white : .mint)
                        .frame(width: 25, height: 25)
                        .padding(3)
                        .offset(x: configuration.isOn ? 15 : -15)

                }
               
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }

}

