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
    
    @Published public var archiveModel: ArchiveModel?
    var archiveCancellable: AnyCancellable?
    
    @Published public var deleteModel: DeleteModel?
    var deleteCancellable: AnyCancellable?
    
    public func archiveRequestToViewModel(_ list: ArchiveModel) {
        self.archiveModel = list
    }
    
    public func archiveRequest(
        userId: String,
        completion: @escaping () -> Void
    
    ) async {
        if let cancellable = archiveCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<MyPageService>(plugins: [MoyaLoggingPlugin()])
        archiveCancellable = provider.requestWithProgressPublisher(.myPageLikes(userId: userId))
            .compactMap { $0.response?.data }
            .receive(on: DispatchQueue.main)
            .decode(type: ArchiveModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크 에러 \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] model in
                if let status = model.status {
                    if status == NetworkCode.success.status {
                        self?.archiveRequestToViewModel(model)
                        print("마이페이지 좋아요 \(model)")
                        completion()
                    } else {
                        
                    }
                }
            })
        
    }
    
    public func deleteToViewModel(_ list: DeleteModel){
        self.deleteModel = list
    }
    
    
    public func deleteRequest(
        likeId: String,
        completion: @escaping () -> Void
    ) async {
        if let cancellable = deleteCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<MyPageService>(plugins: [MoyaLoggingPlugin()])
        deleteCancellable  = provider.requestWithProgressPublisher(.deleteLike(likeId: likeId))
            .compactMap { $0.response?.data }
            .receive(on: DispatchQueue.main)
            .decode(type: DeleteModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("네트워크 에러 \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] model in
                if let status = model.status {
                    if status == NetworkCode.success.status {
                        self?.deleteToViewModel(model)
                        print("마이페이지 좋아요 삭제 \(model)")
                        completion()
                    } else {
                        self?.deleteToViewModel(model)
                        print("마이페이지 좋아요 삭제 \(model)")
                        completion()
                    }
                }
            })
        
        
        
    }
}
