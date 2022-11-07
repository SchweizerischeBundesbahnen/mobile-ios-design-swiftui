//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingTitleWrapperView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    let sbbOnboardingTitleView: SBBOnboardingTitleView
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State var titleHeight: CGFloat = 0
    @State var subtitleHeight: CGFloat = 0
    
    private var buttonView: some View {
        Group {
            if viewModel.state == .startView {
                Button(action: {
                    self.viewModel.state = .cardsView
                }) {
                    Text("Start App tour".localized)
                }
                    .buttonStyle(SBBPrimaryButtonStyle())
                    .background(
                        RoundedRectangle(cornerRadius: 23)
                            .stroke(Color.sbbColor(.white), lineWidth: 1)
                    )
                    .accessibility(identifier: "onboardingTitleViewStartTourButton")
            }
            Button(action: {
                self.viewModel.state = .hidden
            }) {
                Text("End App tour".localized)
            }
                .buttonStyle(SBBPrimaryButtonStyle())
                .background(
                    RoundedRectangle(cornerRadius: 23)
                        .stroke((viewModel.state == .startView) ? Color.clear : .sbbColor(.white), lineWidth: 1)
                )
                .accessibility(identifier: "onboardingTitleViewEndTourButton")
        }
    }
    
    private var portraitView: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Image(sbbName: "sbb-logo", size: .small)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 14)
                    .accessibility(hidden: true)
            }
            sbbOnboardingTitleView
            buttonView
        }
            .sbbScreenPadding()
    }
    
    private var landscapeView: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Image(sbbName: "sbb-logo", size: .small)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 14)
                    .accessibility(hidden: true)
            }
            
            GeometryReader { mainGeometry in
                HStack(spacing: 0) {
                    VStack {
                        Spacer()
                        sbbOnboardingTitleView.imageView
                        Spacer()
                    }
                        .frame(width: mainGeometry.size.width / 2)
                    
                    VStack(alignment: .center, spacing: 16) {
                        GeometryReader { geometry in
                            ScrollView(showsIndicators: false) {
                                VStack(alignment: .center, spacing: 16) {
                                    Spacer()
                                    sbbOnboardingTitleView.titleView
                                        .onPreferenceChange(SizePreferenceKey.self) {
                                            self.titleHeight = $0.height
                                        }
                                    sbbOnboardingTitleView.subtitleView
                                        .onPreferenceChange(SizePreferenceKey.self) {
                                            self.subtitleHeight = $0.height
                                        }
                                    Spacer()
                                }
                                    .sbbScreenPadding(.horizontal)
                                    .frame(width: mainGeometry.size.width / 2, height: getContentHeight(containingViewHeight: geometry.size.height))
                                    .foregroundColor(.sbbColor(.white))
                            }
                        }
                            buttonView
                                .sbbScreenPadding(.horizontal)
                                .frame(width: mainGeometry.size.width / 2)
                        Spacer()
                    }
                }            
            }
        }
            .sbbScreenPadding()
    }
    
    var body: some View {
        Group {
            if self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular {
                portraitView
            } else {
                landscapeView
            }
        }
            .background(Color.sbbColor(.primary).edgesIgnoringSafeArea(.all))
    }
    
    private func getContentHeight(containingViewHeight: CGFloat) -> CGFloat {
        if titleHeight + 16 + subtitleHeight + 16 > containingViewHeight {  // Content is bigger than ScrollView, image height corresponds to imageMinHeight
            return titleHeight + 16 + subtitleHeight + 16
        } else {    // Content is smaller than ScrollView, image can take all the available space
            return containingViewHeight
        }
    }
}

struct OnboardingTitleWrapperView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            OnboardingTitleWrapperView(viewModel: FakeOnboardingViewModels.startView, sbbOnboardingTitleView: FakeSBBOnboardingTitleViews.start)
                .previewDisplayName("StartView")
            OnboardingTitleWrapperView(viewModel: FakeOnboardingViewModels.startView, sbbOnboardingTitleView: FakeSBBOnboardingTitleViews.start)
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
            OnboardingTitleWrapperView(viewModel: FakeOnboardingViewModels.endView, sbbOnboardingTitleView: FakeSBBOnboardingTitleViews.end)
                .previewDisplayName("EndView")
                .environment(\.colorScheme, .dark)
            OnboardingTitleWrapperView(viewModel: FakeOnboardingViewModels.endView, sbbOnboardingTitleView: FakeSBBOnboardingTitleViews.end)
                .previewDisplayName("EndView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
