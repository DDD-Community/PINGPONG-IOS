//
//  SelectTimeSheetView.swift
//  Profile
//
//  Created by 서원지 on 11/18/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import Authorization
import DesignSystem


struct SelectTimeSheetView: View {
    @ObservedObject private var viewModel: ProfileViewViewModel
    
    var closeSheetAction: () -> Void
    
    public init(
        viewModel: ProfileViewViewModel,
        closeSheetAction: @escaping () -> Void
        
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.closeSheetAction = closeSheetAction
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 18)
            
            timeTextHeaderView
            
            Spacer()
                .frame(height: 13)
            
            selectTimeView
            
            Spacer()
                .frame(height: 12)
            
            selectTimeButtonView
        
            
        }
    }
    
    private var timeTextHeaderView: some View {
        HStack {
            Text("시간 추가")
                .pretendardFont(family: .SemiBold, size: 18)
                .foregroundColor(Color.basicGray9)
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    
    private var selectTimeView: some View {
        VStack {
            DatePicker("", selection: $viewModel.selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(width: 200, height: 212)
                .foregroundColor(Color.basicGray9)
                .pretendardFont(family: .SemiBold, size: 18)
        }
    }
    
    private var selectTimeButtonView : some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.primaryOrange)
                .frame(height: 56)
                .padding(.horizontal, 20)
                .overlay {
                    Text("설정 완료")
                        .foregroundStyle(Color.basicWhite)
                        .pretendardFont(family: .SemiBold, size: 16)
                }
                .onTapGesture {
                    closeSheetAction()
                }
                
        }
    }
}


