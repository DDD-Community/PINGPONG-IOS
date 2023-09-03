//
//  SelectCharacterView.swift
//  OnBoarding
//
//  Created by Byeon jinha on 2023/09/03.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import SwiftUI

struct SelectCharacterView: View {
    @StateObject private var viewModel: OnBoardingViewModel
    
    public init(viewModel: OnBoardingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    public var body: some View {
        ZStack {
            VStack {
                topHeaderBackButton()
                    .padding(.top, 20)
                Spacer()
            }
            VStack {
                jobSettingContentView()
                falvorArrayView()
                Spacer()
                confirmButtonView()
                    .padding(.bottom, 30)
            }
            .padding(.top, 40)
            .frame(height: UIScreen.screenHeight * 0.9)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $viewModel.isSelectedCharacter) {
            // 이동할 뷰를 넣어주세요.
            CompleteLoginView(viewModel: self.viewModel)
        }
    }
    
    @ViewBuilder
    private func topHeaderBackButton() -> some View {
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
            NavigationLink(destination: SelectAlamView()) {
                Text("건너뛰기")
                    .pretendardFont(family: .Regular, size: 14)
                    .foregroundColor(.basicGray6)
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func jobSettingContentView() -> some View {
        Group {
            VStack{
                HStack(spacing: 0) {
                    Text("STEP 2/3")
                        .pretendardFont(family: .SemiBold, size: 18)
                        .foregroundColor(.primaryOrangeText)
                        .padding(.bottom, 8)
                    Spacer()
                }
                VStack {
                    HStack(spacing: 0) {
                        Text("선호하는 명언의 성격은")
                        Spacer()
                    }
                    HStack(spacing: 0) {
                        Text("무엇인가요?")
                        Spacer()
                    }
                }
                .pretendardFont(family: .SemiBold, size: 24)
                .padding(.bottom, 8)
                
                HStack(spacing: 0) {
                    Text("원하는 성격의 명언을  ")
                        .pretendardFont(family: .SemiBold, size: 16)
                    Text("최대 2개")
                        .pretendardFont(family: .Bold, size: 16)
                    Text("를 선택해보세요.")
                        .pretendardFont(family: .SemiBold, size: 16)
                    Spacer()
                }
                .foregroundColor(.basicGray6)
                .padding(.bottom, 8)
                
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private func confirmButtonView() -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(viewModel.selectedCharacter.count > 0 ? .primaryOrange : .basicGray3)
                .frame(width: UIScreen.screenWidth - 40 , height: 50)
                .overlay {
                    Text("다음")
                        .foregroundColor(viewModel.selectedCharacter.count > 0 ? .basicWhite : .basicGray5)
                        .font(.system(size: 16))
                        .onTapGesture {
                            viewModel.isLoginJobSettingView.toggle()
                        }
                }
                .disabled(viewModel.selectedCharacter.count < 1)
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
    
    @ViewBuilder
    private func falvorArrayView() -> some View {
        ForEach(self.viewModel.flavorArray.options.indices, id: \.self) { index in
            let flavor: Flavor = Flavor(rawValue: viewModel.flavorArray.options[index].val)!
            let colorSet = viewModel.searchCharacterColor(flavor: flavor)
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(viewModel.flavorArray.options[index].isCheck ? colorSet.icon : .gray, style: .init(lineWidth: 1))
                .frame(width: 336, height: UIScreen.screenHeight * 0.072)
                .background(self.viewModel.flavorArray.options[index].isCheck ? colorSet.background : .basicGray2)
                .overlay(
                    HStack {
                        Circle()
                            .foregroundColor(colorSet.iconBackground)
                            .frame(width: 32, height: 32)
                            .overlay(Text(self.viewModel.flavorArray.options[index].iconImageName))
                            .padding()
                        VStack {
                            HStack {
                                Text(self.viewModel.flavorArray.options[index].val)
                                    .foregroundStyle(Color.basicGray8)
                                    .pretendardFont(family: .Medium, size: 16)
                                Spacer()
                            }
                            HStack {
                                Text(self.viewModel.flavorArray.options[index].detail)
                                    .foregroundStyle(Color.basicGray6)
                                    .pretendardFont(family: .Medium, size: 12)
                                Spacer()
                            }
                        }
                        Spacer()
                        Image(systemName: self.viewModel.flavorArray.options[index].isCheck ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(self.viewModel.flavorArray.options[index].isCheck ? colorSet.icon : .gray)
                            .padding()
                    }
                )
                .onTapGesture {
                    self.viewModel.appendAndPopCharacter(character: viewModel.flavorArray.options[index].val, index: index)
                }
        }
    }
    
}
