//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingTitleView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    let sbbOnboardingTitleView: SBBOnboardingTitleView
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Image("sbb-logo-small", bundle: Helper.bundle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 14)
                
            }
            sbbOnboardingTitleView
            if viewModel.state == .startView {
                Button(action: {
                    self.viewModel.state = .cardsView
                }) {
                    Text("App Rundgang starten")
                }
                    .buttonStyle(SBBPrimaryButtonStyle())
                    .background(
                        RoundedRectangle(cornerRadius: 23)
                            .stroke(SBBColor.white, lineWidth: 1)
                    )
            }
            Button(action: {
                self.viewModel.state = .hidden
            }) {
                Text("App Rundgang beenden")
            }
                .buttonStyle(SBBPrimaryButtonStyle())
                .background(
                    RoundedRectangle(cornerRadius: 23)
                        .stroke((viewModel.state == .startView) ? Color.clear : SBBColor.white, lineWidth: 1)
                )
        }
            .padding(16)
            .background(SBBColor.red.edgesIgnoringSafeArea(.all))
    }
}

struct OnboardingTitleView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            OnboardingTitleView(viewModel: FakeOnboardingViewModels.startView, sbbOnboardingTitleView: FakeSBBOnboardingTitleViews.start)
                .previewDisplayName("StartView")
            OnboardingTitleView(viewModel: FakeOnboardingViewModels.startView, sbbOnboardingTitleView: FakeSBBOnboardingTitleViews.start)
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
            OnboardingTitleView(viewModel: FakeOnboardingViewModels.endView, sbbOnboardingTitleView: FakeSBBOnboardingTitleViews.end)
                .previewDisplayName("EndView")
                .environment(\.colorScheme, .dark)
            OnboardingTitleView(viewModel: FakeOnboardingViewModels.endView, sbbOnboardingTitleView: FakeSBBOnboardingTitleViews.end)
                .previewDisplayName("EndView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
