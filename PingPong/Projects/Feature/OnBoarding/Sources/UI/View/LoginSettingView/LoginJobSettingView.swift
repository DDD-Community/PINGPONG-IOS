//
//  LoginJobSettingView.swift
//  OnBoarding
//
//  Created by Byeon jinha on 2023/09/02.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct LoginJobSettingView: View {
    @StateObject var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @StateObject var appState: OnBoardingAppState = OnBoardingAppState()
    @Environment(\.presentationMode) var presentationMode
    
       public init(viewModel: OnBoardingViewModel) {
           self._viewModel = StateObject(wrappedValue: viewModel)
       }
    
    

    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    public var body: some View {
        ZStack (alignment: .bottom) {
            VStack {
                topHeaderBackButton()
                
                jobSettingContentView()
                
                Spacer()
                confirmButtonView()
                    .padding(.bottom, 30)
            }
            
        }
        .navigationBarHidden(true)
        .task {
            viewModel.onBoardingSearchUserRequest()
            
        }
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
        Spacer()
            .frame(height: 20)
        
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 18)
                .foregroundColor(.gray)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func jobSettingContentView() -> some View {
        Group {
            VStack{
                Spacer()
                    .frame(height: UIScreen.screenWidth*0.2 - 30)
                
                jobTitleViews()
                    .pretendardFont(family: .SemiBold, size: 24)
                    .padding(.horizontal, 20)
                
                
                LazyVGrid(columns: columns, spacing: 10) {
                    let searchUserJob = viewModel.onBoardingSearchUserModel?.data?.filter{$0.commCDTpID == 4}
                    if let firstSearchUserJob = searchUserJob?.first {
                        let sortedCommCds = firstSearchUserJob.commCds?.sorted(by: { $0.commCDID < $1.commCDID }) ?? []
                        ForEach(sortedCommCds, id: \.self) { commCDItem in
                            VStack {
                                if viewModel.selectedJob == commCDItem.commCD {
                                    Circle()
                                        .stroke(Color.primaryOrangeText ,lineWidth: 1)
                                        .frame(width: 96, height: 96)
                                        .overlay(
                                            Circle()
                                                .frame(width: 96, height: 96)
                                                .foregroundColor(.primaryOrangeOpacity40)
                                                .overlay(
                                                    Image(assetName:  commCDItem.commCD == "OTHER" ? "\(commCDItem.commCD)S" : commCDItem.commCD)
                                                )
                                        )
                                } else {
                                    Circle()
                                        .frame(width: 96, height: 96)
                                        .foregroundColor(.basicGray3)
                                        .overlay(
                                            Image(assetName:  commCDItem.commCD == "OTHER" ? "\(commCDItem.commCD)S" : commCDItem.commCD )
                                        )
                                }
                                Text(commCDItem.commNm)
                                    .pretendardFont(family: .SemiBold, size: 14)
                            }
                            .onTapGesture {
                                self.viewModel.selectedJob = commCDItem.commCD
                                self.viewModel.selectJobCode = commCDItem.commCDID
                            }
                        }
                    }
                }

                .padding(EdgeInsets(top: 0, leading: 10, bottom: 62, trailing: 10))
                
            }
        }
    }
    
    @ViewBuilder
    private func jobTitleViews() -> some View {
        VStack {
            HStack(spacing: 0) {
                Text("어떤 일을")
                Spacer()
            }
            HStack(spacing: 0) {
                Text("하고 계신가요?")
                Spacer()
            }
        }
        .pretendardFont(family: .SemiBold, size: 24)
        .padding(.horizontal, 20)
    }
    
    
    @ViewBuilder
    private func confirmButtonView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(viewModel.selectedJob != nil ? .primaryOrange : .basicGray3)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("다음")
                        .foregroundColor(viewModel.selectedJob != nil ? .basicWhite : .basicGray5)
                        .font(.system(size: 16))
                        .onTapGesture {
                            viewModel.viewPath.append(ViewState.isJobSettingComplete)
                        }
                }
                .disabled(viewModel.selectedJob == nil)
        }
    }
    
    @ViewBuilder
    private func validateImageView(imageName: String?) -> some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(viewModel.validationColor)
            }
            EmptyView()
        }
    }
}
