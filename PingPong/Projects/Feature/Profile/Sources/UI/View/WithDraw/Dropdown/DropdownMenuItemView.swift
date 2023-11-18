//
//  DropdownMenuItemView.swift
//  Profile
//
//  Created by Byeon jinha on 11/18/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import Model
import Authorization
import SwiftUI

struct DropdownMenuItemView: View {
    @Binding var isSelecting: Bool
    @Binding var selectiontitle: String
    @Binding var selectionId: Int
    
    let item: DropdownItem
    
    var body: some View {
        Button(action: {
            isSelecting = false
            selectiontitle = item.title
            item.onSelect()
        }) {
            HStack {
                Text(item.title)
                    .foregroundColor(.basicGray9)
                    .pretendardFont(family: .Medium, size: 16)
                    .padding(.leading, 16)
                
                Spacer()
            }
            .frame(width: UIScreen.screenWidth - 40, height: 48)
        }
    }
}
