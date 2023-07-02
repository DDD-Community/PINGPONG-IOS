//
//  FavoriteChoiceListView.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

struct FavoriteChoiceListView: View {
    var favoriteArray: [String]
    var isArray: [Bool]
    var toggleOn: (Int) -> Void
    
    init(favoriteArray: [String], isArray: [Bool], toggleOn: @escaping (Int) -> Void) {
        self.favoriteArray = favoriteArray
        self.isArray = isArray
        self.toggleOn = toggleOn
    }
    
    var body: some View {
        ForEach(favoriteArray.indices) { idx in
            RoundedRectangle(cornerRadius: 16)
                .fill(isArray[idx] ? Color.pink : .white)
                .frame(width: UIScreen.screenWidth - 80, height: 40)
                .overlay {
                    Text(favoriteArray[idx])
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .onTapGesture {
                    toggleOn(idx)
                }
        }
    }
}


