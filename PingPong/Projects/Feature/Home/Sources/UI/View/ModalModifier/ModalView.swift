//
//  ModalView.swift
//  Home
//
//  Created by Byeon jinha on 2023/09/05.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import DesignSystem
import Foundation
import Model
import SwiftUI
import Authorization

public struct ModalView: View {
    let config: SheetManager.Config
    let isPopup: Bool
    
    @StateObject private var viewModel: HomeViewViewModel
    
    let didClose: () -> Void
    
    let height:CGFloat = UIScreen.screenHeight * 0.7
    
    public init(viewModel: HomeViewViewModel, config: SheetManager.Config, isPopup: Bool, didClose: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.config = config
        self.isPopup = isPopup
        self.didClose = didClose
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            headLine
                .frame(height: 60)
            Spacer()
            contents
            filterBox(isButtonAble: viewModel.generateIsButtonAble(situationFlavorSourceTitle: viewModel.searchViewButtonInfoArray[config.idx].title))
        }
        .frame(maxWidth: .infinity, maxHeight: height)
        .padding(.horizontal, 24)
        .padding(.bottom, 50)
        .multilineTextAlignment(.leading)
        .background(background)
        .drawingGroup()
        .offset(y: viewModel.offsetY)
        .transition(.move(edge: .bottom))
        .gesture(
            DragGesture()
                .onChanged { value in
                    if viewModel.offsetY == 0 && value.translation.height > 0 {
                        viewModel.offsetY += value.translation.height / 30
                    }
                    if viewModel.offsetY > 0 {
                        viewModel.offsetY += value.translation.height / 30
                    }
                }
                .onEnded { value in
                    if viewModel.offsetY > 100 {
                        didClose()
                    } else {
                        viewModel.offsetY = 0
                    }
                }
        )
        
    }
}

private extension ModalView {
    var background: some View {
        RoundedCorners(color: .white,
                       tl: 10,
                       tr: 10,
                       bl: 0,
                       br:0)
    }
}

private extension ModalView {
    var headLine: some View {
        HStack {
            Text("\(viewModel.searchViewButtonInfoArray[config.idx].title.rawValue)")
                .pretendardFont(family: .SemiBold, size: 18)
                .foregroundColor(.cardTextMain)
            Spacer()
            Button(action: {
                for idx in viewModel.searchViewButtonInfoArray[config.idx].options.indices {
                    viewModel.searchViewButtonInfoArray[config.idx].options[idx].isCheck = false
                }
                
            }) {
                Text("선택 해제")
                    .pretendardFont(family: .Medium, size: 14)
                    .foregroundColor(.basicGray5)
            }
        }
    }
    
    var contents: some View {
        VStack {
            ForEach(viewModel.searchViewButtonInfoArray[config.idx].options.indices, id: \.self) { idx in
                let option = viewModel.searchViewButtonInfoArray[config.idx].options[idx]
                let situationFlavorSource = SituationFlavorSource(rawValue: option.val)!
                let colorSet = generateSituationFlavorSourceColor(situationFlavorSource: situationFlavorSource)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.searchViewButtonInfoArray[config.idx].options[idx].isCheck ? colorSet.iconBackground : .basicGray3, style: .init(lineWidth: 1))
                    .frame(width: 336, height: 68)
                    .background(viewModel.searchViewButtonInfoArray[config.idx].options[idx].isCheck ? colorSet.background : .basicGray2)
                    .overlay(
                        HStack {
                            Circle()
                                .frame(width: 44, height: 44)
                                .padding()
                                .foregroundColor(colorSet.icon)
                                .overlay(
                                    Image(assetName: situationFlavorSource.imageName)
                                )
                            VStack {
                                HStack {
                                    Text(viewModel.searchViewButtonInfoArray[config.idx].options[idx].val)
                                        .pretendardFont(family: .Medium, size: 16)
                                        .foregroundColor(.basicGray8)
                                    Spacer()
                                }
                                HStack {
                                    Text(viewModel.searchViewButtonInfoArray[config.idx].options[idx].detail)
                                        .pretendardFont(family: .Medium, size: 12)
                                        .foregroundColor(.basicGray6)
                                    Spacer()
                                }
                            }
                            Spacer()
                            Button(action: {
                                viewModel.searchViewButtonInfoArray[config.idx].options[idx].isCheck.toggle()
                            }) {
                                Image(systemName: viewModel.searchViewButtonInfoArray[config.idx].options[idx].isCheck ? "checkmark.circle.fill" : "checkmark.circle")
                                    .foregroundColor(viewModel.searchViewButtonInfoArray[config.idx].options[idx].isCheck ? colorSet.iconBackground : .basicGray4)
                                    .padding()
                            }
                        }
                    )
            }
            .animation(.none, value: UUID())
            Spacer()
        }
        
    }
    @ViewBuilder
    private func errorViewImage() -> some View {
        VStack {
            
            Image(asset: .cloudOff)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
            
        }
    }
    @ViewBuilder
    private func filterBox(isButtonAble: Bool) -> some View  {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 336, height: 68)
            .foregroundColor(.primaryOrange)
            .overlay(
                Text("필터 적용")
                    .foregroundColor(.basicWhite)
            )
            .onTapGesture {
                didClose()
            }
    }
    
}


struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    var top: Bool = true
    var bottom: Bool = true
    var left: Bool = true
    var right: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: 0 + tl, y: 0))
                if tl != 0 || tr != 0 || top == true {
                    path.addLine(to: CGPoint(x: w - tr, y: 0))
                    path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                } else {
                    path.move(to: CGPoint(x: w, y: 0))
                }
                if tr != 0 || br != 0 || right == true {
                    path.addLine(to: CGPoint(x: w, y: h - br))
                    path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                } else {
                    path.move(to: CGPoint(x: w, y: h))
                }
                
                if br != 0 || bl != 0 || bottom == true {
                    path.addLine(to: CGPoint(x: bl, y: h))
                    path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                } else {
                    path.move(to: CGPoint(x: 0, y: h))
                }
                if bl != 0 || tl != 0 || left == true {
                    path.addLine(to: CGPoint(x: 0, y: tl))
                    path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                }
            }
            .stroke(Color.black, lineWidth: 0)
        }
    }
}

enum SituationFlavorSource: String {
    case motivation = "동기부여"
    case consolation = "위로"
    case wisdom = "지혜"
    case sweet = "달콤한 맛"
    case salty = "짭짤한 맛"
    case spicy = "매콤한 맛"
    case nutty = "고소한 맛"
    case light = "담백한 맛"
    case historicalFigures = "위인"
    case celebrities = "유명인"
    case dramaMovies = "드라마/영화"
    case animation = "애니메이션"
    case books = "책"
    
    var imageName: String {
            return "ssf\(self)"
        }
}

private func generateSituationFlavorSourceColor(situationFlavorSource: SituationFlavorSource) -> CharacterColor {
    switch situationFlavorSource {
    case .animation:
        return CharacterColor(icon: .nuttyFilter, iconBackground: .primaryOrange, background: .primaryOrangeOpacity30)
    case .motivation:
        return CharacterColor(icon: .motivateIcon, iconBackground: .primaryOrange, background: .primaryOrangeOpacity30)
    case .consolation:
        return CharacterColor(icon: .consolationIcon, iconBackground: .primaryOrange, background: .primaryOrangeOpacity30)
    case .wisdom:
        return CharacterColor(icon: .wisdomIcon, iconBackground: .primaryOrange, background: .primaryOrangeOpacity30)
    case .sweet:
        return CharacterColor(icon: .sweetFilter, iconBackground: .sweetIconText, background: .sweetBG)
    case .salty:
        return CharacterColor(icon: .saltyIconBG, iconBackground: .saltyIconText, background: .saltyBG)
    case .spicy:
        return CharacterColor(icon: .hotIconBG, iconBackground: .hotIconText, background: .hotBG)
    case .nutty:
        return CharacterColor(icon: .nuttyFilter, iconBackground: .nuttyIconText, background: .nuttyBG)
    case .light:
        return CharacterColor(icon: .mildBG, iconBackground: .mildIconText, background: .mildBG)
    case .historicalFigures:
        return CharacterColor(icon: .sweetFilter, iconBackground: .primaryOrange, background: .primaryOrangeOpacity30)
    case .celebrities:
        return CharacterColor(icon: .saltyIconBG, iconBackground: .primaryOrange, background: .primaryOrangeOpacity30)
    case .dramaMovies:
        return CharacterColor(icon: .hotIconBG, iconBackground: .primaryOrange, background: .primaryOrangeOpacity30)
    case .books:
        return CharacterColor(icon: .mildIconBG, iconBackground: .primaryOrange, background: .primaryOrangeOpacity30)
    }
}
