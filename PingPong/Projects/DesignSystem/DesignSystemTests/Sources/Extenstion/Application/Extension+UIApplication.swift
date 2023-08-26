//
//  Extension+UIApplication.swift
//  Component
//
//  Created by 서원지 on 2023/06/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

public extension UIApplication {
    //MARK:  - 키보드에서 end 하면  키보드 내리기
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    public static let safeAreaInsets = UIApplication.shared.windows[0].safeAreaInsets
    public static let contentsHeight = UIScreen.screenHeight - UIApplication.safeAreaInsets.top - UIApplication.safeAreaInsets.bottom
    public static let contentsWidth = UIScreen.screenWidth - UIApplication.safeAreaInsets.left - UIApplication.safeAreaInsets.right
}

