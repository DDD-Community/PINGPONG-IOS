//
//  DropdownItem.swift
//  Model
//
//  Created by Byeon jinha on 11/18/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct DropdownItem: Identifiable {
    public let id: Int
    public let title: String
    public let onSelect: () -> Void
    
    public init(id: Int, title: String, onSelect: @escaping () -> Void) {
        self.id = id
        self.title = title
        self.onSelect = onSelect
    }
}
