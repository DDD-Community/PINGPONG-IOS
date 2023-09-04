//
//  ProfileView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import DesignSystem
import SwiftUI
import Authorization
import Inject

public struct ProfileView: View {
    
    var backProfileViewAction: () -> Void = {}
    
    @StateObject var io = Inject.observer
    @StateObject var authViewModel: AuthorizationViewModel = AuthorizationViewModel()
    
    
    public init(backProfileViewAction: @escaping () -> Void) {
        self.backProfileViewAction = backProfileViewAction
        
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                Color.basicGray1BG
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    profileSettingTopView()
                    
                    profileNickNameView()
                    
                    profileTasteMangeMent()
                    
                    Spacer()
                    
                }
            }
        }
        .enableInjection()
        .task {
            authViewModel.searchUserIdRequest(uid: "103")
        }
    }
    
    @ViewBuilder
    private func profileSettingTopView() -> some View {
        VStack {
            Spacer()
                .frame(height: 18)
            
            HStack(spacing: 8) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 18)
                    .onTapGesture {
                        backProfileViewAction()
                    }
                
                Spacer()
                    .frame(width: 8)
                
                Text("설정")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(Color.basicBlack)
                
                
                Spacer()
                
            }
            .padding(.horizontal, 20)
            
        }
    }
    
    @ViewBuilder
    private func profileNickNameView() -> some View {
        Spacer()
            .frame(height: 32)
        
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.basicWhite)
                .frame(width: UIScreen.screenWidth - 40, height: 81)
                .overlay {
                    HStack {
                        Circle()
                            .fill(Color.sweetFilter)
                            .frame(width: 57, height: 57)

                        Spacer()
                            .frame(width: 16)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("\(authViewModel.signupModel?.data?.nickname ?? "")")
                                    .pretendardFont(family: .SemiBold, size: 18)
                                    .foregroundColor(.basicGray9)
                                
                                Spacer()
                                
                                Image(asset: .profileEdit)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            
                            Text(authViewModel.signupModel?.data?.rmk ?? "")
                                .pretendardFont(family: .Medium, size: 14)
                                .foregroundColor(.basicGray7)
                            
                            
                        }
                    }
                }
        }
    }

    @ViewBuilder
    private func profileTasteMangeMent() -> some View {
        Spacer()
            .frame(height: 16)
        
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.basicWhite)
            .frame(width: UIScreen.screenWidth - 40, height: 150)
            .overlay {
                VStack {
                    HStack {
                        Text("명언 취향 관리")
                            .pretendardFont(family: .SemiBold, size: 18)
                            .foregroundColor(.basicGray8)
                        
                        Spacer()
                        
                        Image(asset: .profileEdit)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                    }
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.basicWhite)
                        .frame(height: 44)
                        .overlay {
                            HStack {
                                Text("명언 유형")
                                    .pretendardFont(family: .Medium, size: 14)
                                    .foregroundColor(.basicGray7)
                                
                                Spacer()
                            }
                        }
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.basicWhite)
                        .frame(height: 44)
                        .overlay {
                            HStack {
                                Text("명언 성향")
                                    .pretendardFont(family: .Medium, size: 14)
                                    .foregroundColor(.basicGray7)
                                
                                Spacer()
                            }
                        }
                    
                }
            }
    }
}
