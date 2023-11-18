//
//  CustomDropdownMenu.swift
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


struct CustomDropdownMenu: View {
    @State var isSelecting = false
    @State var selectionTitle = "이런 점이 불편했어요."
    @State var selectedRowId = 0
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(isSelecting ? "선택해주세요." : selectionTitle)
                            .pretendardFont(family: .Medium, size: 16)
                            .foregroundColor(isSelecting ? .basicGray5 : .basicGray7)
                            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 0))
                        Spacer()
                        VStack {
                            Image(systemName: isSelecting ? "chevron.up" : "chevron.down")
                                .foregroundColor(.basicGray8)
                                .padding(16)
                            Spacer()
                        }
                    }
                    if isSelecting {
                        
                        VStack(spacing: 0) {
                            DropdownMenuItemView(isSelecting: $isSelecting, selectiontitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 1, title: "서비스 이용이 불편해요.", onSelect: {}))
                            DropdownMenuItemView(isSelecting: $isSelecting, selectiontitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 2, title: "명언이 마음에 들지 않아요.", onSelect: {}))
                            DropdownMenuItemView(isSelecting: $isSelecting, selectiontitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 3, title: "비슷한 서비스 앱이 더 좋아요.", onSelect: {}))
                            DropdownMenuItemView(isSelecting: $isSelecting, selectiontitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 3, title: "자주 사용하지 않아요.", onSelect: {}))
                        }
                    }
                }
            }
            .frame(width: UIScreen.screenWidth - 40, height: isSelecting ? 240 : 48)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.basicGray4)
            )
            .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .cornerRadius(5)
        .onTapGesture {
            isSelecting.toggle()
        }
    }
    
}
