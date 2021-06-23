//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    private let startView = SBBOnboardingTitleView(image: Image("Onboarding_Gang"), title: Text("Willkommen bei der Design System Mobile Library Demo App"))
    private let endView = SBBOnboardingTitleView(image: Image("Onboarding_Gang"), title: Text("Wir wünschen Ihnen viel Spass beim Erkunden aller Design System Mobile Elemente"))

    var body: some View {
        SBBOnboardingView(state: $viewModel.onboardingState, currentCardIndex: $viewModel.currentOnboardingCardIndex, startView: startView, endView: endView) {
            SBBOnboardingCardView(image: Image("Onboarding_Train"), title: Text("Design System Mobile"), text: Text("Dank dem Design System Mobile sind alle SBB Apps auf den ersten Blick als solche erkennbar und einfach benutzbar."))
            SBBOnboardingCardView(image: Image("Onboarding_Train"), title: Text("SwiftUI Library"), text: Text("Dank Mobile Libraries für iOS und Android, können Entwickler Benutzeroberflächen für neue Apps rasch und nach SBB Standards erstellen."))
            SBBOnboardingCardView(image: Image("Onboarding_Train"), title: Text("Verwendung der Library"), text: Text("Hinter der Library stecken die DSRVs AppBakery und UX. Wir entwickeln diese weiter und warten sie. Nimm jetzt Kontakt mit uns auf!"))
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView()
                .previewDisplayName("Light StartView")
                .environmentObject(OnboardingViewModel(onboardingState: .startView))
            OnboardingView()
                .previewDisplayName("Light CardsView")
                .environmentObject(OnboardingViewModel(onboardingState: .cardsView))
            OnboardingView()
                .previewDisplayName("Dark CardsView")
                .environment(\.colorScheme, .dark)
                .environmentObject(OnboardingViewModel(onboardingState: .cardsView))
            OnboardingView()
                .previewDisplayName("Light EndView")
                .environmentObject(OnboardingViewModel(onboardingState: .endView))
        }
    }
}
