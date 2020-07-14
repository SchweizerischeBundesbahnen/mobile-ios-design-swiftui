//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingCardsView: View {
    
    @Binding var onboardingState: SBBOnboardingState
    
    var body: some View {
        VStack {
            Button(action: {
                self.onboardingState = .endView
            }) {
                Text("weiter...")
            }
            Button(action: {
                self.onboardingState = .hidden
            }) {
                Text("Rundgang abbrechen")
            }
        }
    }
}

struct OnboardingCardsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingCardsView(onboardingState: .constant(.startView))
                .previewDisplayName("Light")
            OnboardingCardsView(onboardingState: .constant(.startView))
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
