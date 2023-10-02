//
//  CustomTab.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import SwiftUI

public struct CustomTab {
    public var name: String
    public var imageName: String
    public var tab: Tab
    public var view: AnyView
    public var isOn: Bool
    
    public init(name: String, imageName: String, tab: Tab, view: AnyView, isOn: Bool) {
        self.name = name
        self.imageName = imageName
        self.tab = tab
        self.view = view
        self.isOn = isOn
    }
}
