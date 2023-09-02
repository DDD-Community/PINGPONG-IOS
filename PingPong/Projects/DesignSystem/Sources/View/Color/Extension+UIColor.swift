//
//  Extension+UIColor.swift
//  Component
//
//  Created by 서원지 on 2023/06/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
   
    
}

public extension UIColor {
 
    static func pingPongColor (_ color: Colors) -> UIColor? {
        return UIColor(named: color.rawValue,  in: Bundle.module, compatibleWith:  nil)
    }
}

