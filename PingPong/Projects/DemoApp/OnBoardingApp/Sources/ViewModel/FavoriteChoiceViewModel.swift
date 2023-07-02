//
//  FavoriteChoiceViewModel.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

class FavoriteChoiceViewModel: ObservableObject {
    @Published var pushSettingView: Bool = false
    @Published var arrayIM: [String]
    @Published var isIM: [Bool]
    @Published var arrayFavorite: [String]
    @Published var isFavorite: [Bool]
    @Published var choiceCount: Int
    
    init() {
        arrayIM = []
        isIM = []
        arrayFavorite = []
        isFavorite = []
        choiceCount = 0
        
        initializeArrays()
    }
    
    private func initializeArrays() {
        arrayIM = ["다정하고 상냥한 사람", "약간은 감성적이고 약간은 센치한 사람", "아닌 건 아닌 강단있고 자기 주장 확고한 사람", "열정적이고 의지가 불타는 사람", "유머러스한 사람"]
        isIM = Array(repeating: false, count: arrayIM.count)
        
        arrayFavorite = ["시간이 흘러도 변치 않는 진한 클래식함", "시간이 흘러도 변치 않는 진한 클래식함", "시간이 흘러도 변치 않는 진한 클래식함", "시간이 흘러도 변치 않는 진한 클래식함", "시간이 흘러도 변치 않는 진한 클래식함"]
        isFavorite = Array(repeating: false, count: arrayFavorite.count)
    }
    
    func toggleIM(at index: Int) {
        isIM[index].toggle()
        
        if isIM[index] {
            choiceCount += 1
        } else {
            choiceCount -= 1
        }
        
        if choiceCount > 2 {
            isIM[index].toggle()
            choiceCount -= 1
        }
    }
    
    func toggleFavorite(at index: Int) {
        isFavorite[index].toggle()
    }
}
