//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingTitleView: View {
    
    @ObservedObject var viewModel: SBBOnboardingViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                VStack(spacing: 36) {
                    Spacer()
                    if viewModel.state == .startView {
                        viewModel.startViewModel.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        viewModel.startViewModel.title
                    } else if viewModel.state == .endView {
                        viewModel.endViewModel.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        viewModel.endViewModel.title
                    }
                        
                    Spacer()
                }
                Spacer()
            }
                .font(.sbbLight(size: 30))
                .multilineTextAlignment(.center)
                .foregroundColor(SBBColor.white)
            if viewModel.state == .startView {
                Button(action: {
                    self.viewModel.state = .cardsView
                }) {
                    Text("App Rundgang starten")
                }
            }
            Button(action: {
                self.viewModel.state = .hidden
            }) {
                Text("App Rundgang beenden")
            }
        }
            .padding(16)
            .background(SBBColor.red.edgesIgnoringSafeArea(.all))
    }
}

struct OnboardingTitleView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            OnboardingTitleView(viewModel: FakeSBBOnboardingViewModels.startView)
                .previewDisplayName("StartView")
            OnboardingTitleView(viewModel: FakeSBBOnboardingViewModels.startView)
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
            OnboardingTitleView(viewModel: FakeSBBOnboardingViewModels.endView)
                .previewDisplayName("EndView")
                .environment(\.colorScheme, .dark)
            OnboardingTitleView(viewModel: FakeSBBOnboardingViewModels.endView)
                .previewDisplayName("EndView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
