//
//  ProfileViewComponentModel.swift
//  Model
//
//  Created by Byeon jinha on 11/9/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct ProfileViewComponentModel: Identifiable, Equatable {
    public var isDevider: Bool
    public var imageName: String
    public var id: UUID
    public var content: String
    public var detail: String
    
    public init(isDevider: Bool, imageName: String, content: String, detail: String) {
        self.isDevider = isDevider
        self.imageName = imageName
        self.id = UUID()
        self.content = content
        self.detail = detail
    }
}
