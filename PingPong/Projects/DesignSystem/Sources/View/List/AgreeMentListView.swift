//
//  AgreeMentListView.swift
//  DesignSystem
//
//  Created by 서원지 on 2023/06/25.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI

public struct AgreeMentListView: View {
    
    @Binding var checkAgreeButton: Bool
    var showleft: Bool
    var title: String
    var agreeAllService: Bool
    var essential: TermsEssential
    
    public init(checkAgreeButton: Binding<Bool>, showleft: Bool, title: String, agreeAllService: Bool, essential: TermsEssential) {
        self._checkAgreeButton = checkAgreeButton
        self.showleft = showleft
        self.title = title
        self.agreeAllService = agreeAllService
        self.essential = essential
    }
    
    
    public var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(agreeAllService ? .basicGray3 : .clear)
            VStack{
                HStack {
                    if agreeAllService {
                        Image(systemName: checkAgreeButton ? "checkmark.circle.fill" : "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(checkAgreeButton ? .primaryOrange : .basicGray5)
                            .onTapGesture {
                                checkAgreeButton.toggle()
                            }
                    } else {
                        Image(systemName: checkAgreeButton ? "checkmark.circle.fill" : "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(checkAgreeButton ? .primaryOrange : .basicGray5)
                            .onTapGesture {
                                checkAgreeButton.toggle()
                            }
                    }
                    
                    
                    Text(title)
                        .font(.system(size: 16))
                        .foregroundColor(.basicGray9)
                    if !agreeAllService {
                        Text(essential.rawValue)
                            .font(.system(size: 16))
                            .foregroundColor(essential == .essential ? .primaryOrange : .basicGray5)
                    }
                    
                    
                    Spacer()
                    
                    if showleft {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                        
                    } else {
                        Spacer()
                        
                    }
                    
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
        }
        .frame(height: agreeAllService ? 56 : 35)
        .padding(.horizontal, 20)
    }
}

struct AgreeMentListView_Previews: PreviewProvider {
    static var previews: some View {
        AgreeMentListView(checkAgreeButton: .constant(true), showleft: false, title: "", agreeAllService: true, essential: .essential)
    }
}

public enum TermsEssential: String {
    case essential = "(필수)"
    case choice = "(선택)"
}
