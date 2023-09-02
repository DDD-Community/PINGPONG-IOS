//
//  OnBoardingPushViiew.swift
//  OnBoarding
//
//  Created by 서원지 on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import Foundation
import DesignSystem
import SwiftUI

public struct OnBoardingPushViiew: View {
    @Environment(\.presentationMode) var presentationMode
    
    public init() {
        
    }
    
    public var body: some View {
        ZStack {
            Color.basicWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                onboardingBackButton()
                
                exampleWiseSayingView()
                
                stepContentTitleView()
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func onboardingBackButton() -> some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            HStack {
                Spacer()
                    .frame(width: 20)
                
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 18)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
                Spacer()
                
                Text("건너뛰기")
                    .pretendardFont(family: .Regular, size: 14)
                    .foregroundColor(.basicGray6)
                    .onTapGesture {
                        
                    }
                
                Spacer()
                    .frame(width: 23)
                
            }
        }
    }
    
    @ViewBuilder
    private func exampleWiseSayingView() -> some View {
        Spacer()
            .frame(height: 12)
        
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.basicGray3)
                .frame(width: UIScreen.screenWidth - 40, height: 120)
                .overlay {
                    HStack {
                        RoundedRectangle(cornerRadius: 8.67)
                            .fill(Color.primaryOrange)
                            .frame(width: 38, height: 38)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("오늘의 명언")
                                    .pretendardFont(family: .SemiBold, size: 16)
                                Spacer()
                            }
                            HStack {
                                Text("스스로 돌아봐도 잘못이 없다면  천만인이")
                                    .pretendardFont(family: .Regular, size: 14)
                                    .foregroundColor(Color.basicGray8)
                                
                               Spacer()
                            }
                            HStack {
                                Text("가로막더라도 나는 가리라")
                                    .pretendardFont(family: .Regular, size: 14)
                                    .foregroundColor(Color.basicGray8)
                            Spacer()
                            }
                            
                            Text("-맹자-")
                                .pretendardFont(family: .Regular, size: 14)
                                .foregroundColor(Color.basicGray8)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                }
        }
    }
    
    @ViewBuilder
    private func stepContentTitleView() -> some View {
        Spacer()
            .frame(height: 28)
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("STEP 3/3")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(Color.primaryOrange)
                
                Spacer()
            }
            
            Text("갓 나온 따근따근한 명언 배달은")
                .pretendardFont(family: .SemiBold, size: 24)
                .foregroundColor(.black)
            
            Text("어떠신가요?")
                .pretendardFont(family: .SemiBold, size: 24)
                .foregroundColor(.black)
            
            Text("푸쉬 알림을 설정 하면")
                .pretendardFont(family: .Regular, size: 18)
                .foregroundColor(Color.basicGray6)
            
            Text("제빵사님을 위한 명언을 보내드려요")
                .pretendardFont(family: .Regular, size: 18)
                .foregroundColor(Color.basicGray6)
            
        }
        .padding(.horizontal, 20)
        
    }
}
