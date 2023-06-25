//
//  AgreeMentListView.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/06/25.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

public struct AgreeMentListView: View {
    
    @Binding var checkAgreeButton: Bool
    var showleft: Bool
    var title: String
    var showBold: Bool
    
    public init(checkAgreeButton: Binding<Bool>, showleft: Bool, title: String, showBold: Bool) {
        self._checkAgreeButton = checkAgreeButton
        self.showleft = showleft
        self.title = title
        self.showBold = showBold
    }
    
    
    public var body: some View {
        VStack{
            HStack {
                Image(systemName: checkAgreeButton ? "checkmark.circle.fill" : "checkmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(checkAgreeButton ? .green : .gray)
                    .onTapGesture {
                        checkAgreeButton.toggle()
                    }
                    
                if showBold == true {
                    Text(title)
                        .font(.system(size: 16))
                        .bold()
                } else {
                    Text(title)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                    
                
                Spacer()
                
                if showleft == true {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.gray)
                    
                } else {
                    Spacer()
                    
                }
                
            }
            Spacer()
                .frame(height: 20)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
    }
}

struct AgreeMentListView_Previews: PreviewProvider {
    static var previews: some View {
        AgreeMentListView(checkAgreeButton: .constant(true), showleft: false, title: "", showBold: true)
    }
}
