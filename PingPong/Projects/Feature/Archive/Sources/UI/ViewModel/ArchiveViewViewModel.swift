//
//  ArchiveViewViewModel.swift
//  Archive
//
//  Created by Byeon jinha on 2023/10/04.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import Combine
import Moya
import CombineMoya
import API
import Service
import Model

public class ArchiveViewViewModel: ObservableObject {
    
    public init() { }
    
    @Published public var isAscendingOrder = true
    
 
    
    @Published public var deleteModel: DeleteModel?
    var deleteCancellable: AnyCancellable?
    
    
}
