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
                Image("sbb-logo-small", bundle: Helper.bundle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 14)
                
            }
            HStack {
                Spacer()
                VStack(spacing: 36) {
                    Spacer()
                    if viewModel.state == .startView {
                        viewModel.startViewModel.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        viewModel.startViewModel.title
                            .fixedSize(horizontal: false, vertical: true)
                    } else if viewModel.state == .endView {
                        viewModel.endViewModel.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        viewModel.endViewModel.title
                            .fixedSize(horizontal: false, vertical: true)
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
