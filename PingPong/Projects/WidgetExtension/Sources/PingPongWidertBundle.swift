//
//  PingPongWidertBundle.swift
//  PingPongWidert
//
//  Created by 서원지 on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
struct PingPongWidertBundle: WidgetBundle {
    var body: some Widget {
        PingPongWidert()
        PingPongWidertLiveActivity()
    }
}
