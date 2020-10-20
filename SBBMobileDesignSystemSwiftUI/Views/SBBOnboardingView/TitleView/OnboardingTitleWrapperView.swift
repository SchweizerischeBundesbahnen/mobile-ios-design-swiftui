//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingTitleWrapperView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    let sbbOnboardingTitleView: SBBOnboardingTitleView
    
    var body: some View {
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
                .accessibility(addTraits: .isHeader)
                .accessibility(identifier: "onboardingTitleViewText")
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
            .padding(16)
            .background(Color.sbbColor(.red).edgesIgnoringSafeArea(.all))
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
