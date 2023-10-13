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
    public let source: Source
    public let mood: Mood
    
    public init(flavor: Flavor, source: Source, mood: Mood) {
        self.flavor = flavor
        self.source = source
        self.mood = mood
    }
}
