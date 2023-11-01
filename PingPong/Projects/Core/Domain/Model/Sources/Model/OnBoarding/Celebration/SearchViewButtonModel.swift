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
    public var title: SearchType {
        return self.searchType
    }
    private var searchType: SearchType
    public var shouldShowDropdown = false
    public var options: [SearchOption]
    
    public var count: Int {
        return options.filter {
            $0.isCheck
        }.count
    }
    
    public var choicedTitle: String {
      
        
        if self.count != 1 {
            guard let title: String = options.filter({ $0.isCheck }).first?.val else { return  self.title.rawValue }
            return "\(title) +\(self.count - 1)"
        }
        return options.filter { $0.isCheck }.first?.val ?? self.title.rawValue
    }
    
    public var onSelect: ((_ key: String) -> Void)?

    public init(title: SearchType, shouldShowDropdown: Bool = false, options: [SearchOption], onSelect: ( (_: String) -> Void)? = nil) {
        self.searchType = title
        self.shouldShowDropdown = shouldShowDropdown
        self.options = options
        self.onSelect = onSelect
    }
}

public protocol SearchViewButtonInfoProtocol {
    var title: SearchType { get }
}

