//
//  SearchViewButtonModel.swift
//  Model
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct SearchViewButtonInfo: Identifiable, SearchViewButtonInfoProtocol {
    public let id: UUID = UUID()
    public var title: SearchType
    public var shouldShowDropdown = false
    public var options: [SearchOption]
    public var onSelect: ((_ key: String) -> Void)?
    
    public init(title: SearchType, shouldShowDropdown: Bool = false, options: [SearchOption], onSelect: ( (_: String) -> Void)? = nil) {
        self.title = title
        self.shouldShowDropdown = shouldShowDropdown
        self.options = options
        self.onSelect = onSelect
    }
}

protocol SearchViewButtonInfoProtocol {
    var title: SearchType { get }
}
