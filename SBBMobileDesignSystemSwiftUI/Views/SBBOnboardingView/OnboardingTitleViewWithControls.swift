//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingTitleViewWithControls: View {
    
    @Binding var onboardingState: SBBOnboardingState
    
    let onboardingTitleView: SBBOnboardingTitleView
    
    var body: some View {
        VStack(spacing: 16) {
            onboardingTitleView
            if onboardingState == .startView {
                Button(action: {
                    self.onboardingState = .cardsView
                }) {
                    Text("App Rundgang starten")
                }
            }
            Button(action: {
                self.onboardingState = .hidden
            }) {
                Text("App Rundgang beenden")
            }
        }
            .padding(16)
            .background(SBBColor.red.edgesIgnoringSafeArea(.all))
    }
}

struct OnboardingTitleViewWithControls_Previews: PreviewProvider {
    static let onboardingTitleView = SBBOnboardingTitleView(image: Image(systemName: "car"), title: Text("Test title"))
    
    static var previews: some View {
        Group {
            OnboardingTitleViewWithControls(onboardingState: .constant(.startView), onboardingTitleView: onboardingTitleView)
                .previewDisplayName("StartView")
            OnboardingTitleViewWithControls(onboardingState: .constant(.startView), onboardingTitleView: onboardingTitleView)
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
            OnboardingTitleViewWithControls(onboardingState: .constant(.endView), onboardingTitleView: onboardingTitleView)
                .previewDisplayName("EndView")
                .environment(\.colorScheme, .dark)
            OnboardingTitleViewWithControls(onboardingState: .constant(.endView), onboardingTitleView: onboardingTitleView)
                .previewDisplayName("EndView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
