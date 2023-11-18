//
//  WithDrawView.swift
//  Profile
//
//  Created by 서원지 on 11/18/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Common
import DesignSystem
import Model
import Authorization
import SwiftUI


struct WithDrawView: View {
    @StateObject private var profileViewModel: ProfileViewViewModel = ProfileViewViewModel()
    @ObservedObject var authViewModel: AuthorizationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    public init(authViewModel: AuthorizationViewModel) {
        self._authViewModel = ObservedObject(wrappedValue: authViewModel)
    }
    
    var body: some View {
        ZStack {
            Color.basicGray2
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                topHeaderBackButton()
                CustomDropdownMenu()
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        Spacer()
            .frame(height: 16)
        
        HStack {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 18)
                    .foregroundColor(.basicGray8)
                
                Text("회원 탈퇴")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(.basicBlack)
            }
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
            
           
            Spacer()
        }
        .padding(.horizontal, 20)
        
        Spacer()
            .frame(height: 16)
    }
}


struct CustomDropdownMenu: View {
    @State var isSelecting = false
    @State var selectionTitle = "Selected option"
    @State var selectedRowId = 0

    var body: some View {
        VStack {
            HStack {
                Text(selectionTitle)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))

                Spacer()
                Image(systemName: "chevron.down")
                .font(.system(size: 16, weight: .semibold))
            }
            .padding(.horizontal)
            .foregroundColor(.white)

            if isSelecting {
                Divider()
                    .background(.white)
                    .padding(.horizontal)

                VStack(spacing: 5) {
                    DropdownMenuItemView(isSelecting: $isSelecting, selectiontitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 1, title: "Messages", iconImage: Image(systemName: "envelope"), onSelect: {}))
                    DropdownMenuItemView(isSelecting: $isSelecting, selectiontitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 2, title: "Archived", iconImage: Image(systemName: "archivebox"), onSelect: {}))
                    DropdownMenuItemView(isSelecting: $isSelecting, selectiontitle: $selectionTitle, selectionId: $selectedRowId, item: .init(id: 3, title: "Trash", iconImage: Image(systemName: "trash"), onSelect: {}))
                }

            }

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(Color(uiColor: UIColor.systemIndigo))
        .cornerRadius(5)
        .onTapGesture {
            isSelecting.toggle()
        }
    }

}

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
                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                Text(item.title)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                Spacer()
                item.iconImage
            }
            .padding(.horizontal)
            .foregroundColor(.white)
        }
    }
}

struct DropdownItem: Identifiable {
    let id: Int
    let title: String
    let iconImage: Image
    let onSelect: () -> Void
}
