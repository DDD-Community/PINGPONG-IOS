//
//  SearchMainView.swift
//  PingPongProject
//
//  Created by Byeon jinha on 2023/06/01.
//

import SwiftUI
import Inject
import OnBoarding
import DesignSystem


public struct SearchMainView: View {
    @ObservedObject private var i0 = Inject.observer
    
    public init() {
//        self.i0 = i0
    }
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("test")
            Text("test")
           
            
        }
        .padding()

    }
}

public struct SearchMainView_Previews: PreviewProvider {
    public static var previews: some View {
        SearchMainView()
    }
}

public struct LoadingView_Previews: PreviewProvider {
    public static var previews: some View {
        FloaterPOPUP(image: .errorCircle_rounded, floaterTitle: "알림", floaterSubTitle: "회원가입에 오류가 생겼습니다. 다시 시도해주세요")
    }
}

public struct Loading2View_Previews: PreviewProvider {
    public static var previews: some View {
        CustomPOPUP(image: .cloudOff,
                    title: "인터넷 연결이",
                    title1: "불안정해요",
                    subTitle: "잠시후 다시 시도해보세요",
                    useGif: false,
                    confirmAction: {})
            .colorScheme(.dark)

    }
}

public struct Loading3View_Previews: PreviewProvider {
    public static var previews: some View {
        @StateObject var viewModel = OnBoardingViewModel()
//        NetworkingErrorView(refreshAction: {})
        NavigationStack {
            OnBoardingPushView(viewModel: viewModel)
        }
    }
}

public struct Loading4View_Previews: PreviewProvider {
    public static var previews: some View {
        @StateObject var viewModel = OnBoardingViewModel()
//        NetworkingErrorView(refreshAction: {})
//        CompletedPushNotificationView(isActivePushNotifcation: .constant(false), viewModel: viewModel)
        CompletOnBoardingView(viewModel: viewModel)
    }
}

public struct Loading5View_Previews: PreviewProvider {
    public static var previews: some View {
        SelectCategoryView(viewModel: OnBoardingViewModel())
    }
}
