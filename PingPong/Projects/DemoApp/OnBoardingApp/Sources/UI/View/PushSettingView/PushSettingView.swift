//
//  PushSettingView.swift
//  OnBoardingApp
//
//  Created by Byeon jinha on 2023/07/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import SwiftUI

struct PushSettingView: View {
    @StateObject var viewModel: PushSettingViewModel = PushSettingViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack{
                    Text("갓 나온 따끈따끈한 명언 배달은")
                        .font(.system(size: 22, weight: .bold))
                    Text("어떠신가요?")
                        .font(.system(size: 22, weight: .bold))
                }
                .padding(.top, 46)
                
                VStack{
                    Text("푸시 알림을 설정하시면")
                        .font(.system(size: 18))
                    Text("제빵사님을 위한 명언을 보내드립니다")
                        .font(.system(size: 18))
                }
                .padding(.top, 25)
                
                HStack{
                    Toggle("명언 배달 받기", isOn: $viewModel.isNoti)
                        .font(.system(size: 18, weight: .bold))
                        .padding(EdgeInsets(top: 76, leading: 34, bottom: 0, trailing: 34))
                }
                
                DatePicker("시간", selection: $viewModel.hour, displayedComponents: .hourAndMinute)
                    .padding(EdgeInsets(top: 50, leading: 34, bottom: 0, trailing: 34))
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(viewModel.isNoti ? .green : .gray)
                            .frame(width: UIScreen.screenWidth - 80, height: 40)
                            .overlay {
                                Text(viewModel.isNoti ? "알림을 주세요" : "아직은 생각이 없어요")
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                            .onTapGesture {
                                viewModel.bakeBreadView.toggle()
                            }
                    )
            }
            .navigationDestination(isPresented: $viewModel.bakeBreadView) {
                BakeBreadView()
            }
            .navigationBarBackButtonHidden()
        }
    }
}
