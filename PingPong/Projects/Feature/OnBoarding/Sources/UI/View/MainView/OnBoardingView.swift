//
//  OnBoardingView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI
import Inject
import DesignSystem


public struct OnBoardingView: View {
    @ObservedObject private var i0 = Inject.observer
    
    @State private var serviceUseAgmentView: Bool = false
    
    public init() {
        //        self.i0 = i0
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: UIScreen.screenHeight/8)
                    
                    Text("명언제과점에 오신걸 환영합니다")
                        .bold()
                        .font(.system(size: 22))
                    
                    
                    loadingAnimationView()
                    
                    cookeWiseSayingView()
                    
                    socialLoginButtonView()
                    
                    lookAroundService()
                    
                    Spacer(minLength: .zero)
                }
            }
            .bounce(false)
            
            .navigationDestination(isPresented: $serviceUseAgmentView) {
                ServiceUseAgmentView()
            }
        }
        .enableInjection()
        
    }
    
    @ViewBuilder
    private func loadingAnimationView() -> some View {
        
        Spacer()
            .frame(height: UIScreen.screenWidth/7)
        
        Circle()
            .fill(.gray.opacity(0.4))
            .frame(width: 214, height: 214)
    }
    
    
    @ViewBuilder
    private func cookeWiseSayingView() -> some View {
        Spacer()
            .frame(height: UIScreen.screenWidth/7)
        
        VStack(alignment: .center) {
            Text("어제 보다 오늘 더 ")
            Text("맛있는 명언을 굽고 있어요")
        }
        .font(.system(size: 22))
    }
    
    @ViewBuilder
    private func socialLoginButtonView() -> some View {
        Spacer()
            .frame(height: UIScreen.screenWidth/7)
        
        VStack(spacing: .zero)  {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray.opacity(0.7))
                .frame(width: UIScreen.screenWidth - 80, height: UIScreen.screenHeight*0.06)
                .overlay {
                    Text("카카오톡으로 로그인")
                        .font(.system(size: 18))
                }
            
            Spacer()
                .frame(height: 12)
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray.opacity(0.7))
                .frame(width: UIScreen.screenWidth - 80, height: UIScreen.screenHeight*0.06)
                .overlay {
                    Text("애플로 로그인")
                        .font(.system(size: 18))
                }
            
            
            
        }
    }
    
    @ViewBuilder
    private func lookAroundService() -> some View {
        Spacer()
            .frame(height: 22)
        VStack(alignment: .center) {
            Text("서비스 둘러보기")
                .font(.system(size: 18))
                .onTapGesture {
                    serviceUseAgmentView.toggle()
                }
        }
    }
    
}

public struct OnBoardingView_Previews: PreviewProvider {
    public static var previews: some View {
        OnBoardingView()
    }
}
