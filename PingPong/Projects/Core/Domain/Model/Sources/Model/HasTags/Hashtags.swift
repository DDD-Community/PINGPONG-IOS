//
//  Hashtags.swift
//  Model
//
//  Created by 서원지 on 10/2/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation

public struct Hashtags {
    public let flavor: Flavor
    public let source: Sources
    public let situation: Situations
    
    public init(flavor: Flavor, source: Sources, situation: Situations) {
        self.flavor = flavor
        self.source = source
        self.situation = situation
    }
    
}
