//
//  SharedManger.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/09/07.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import UIKit

public struct SharedManger {
    public static let shared = SharedManger()
    
    public init() {}
    
    public func shareContent(content: UIImage) {
        let avc = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
    }
    
}
