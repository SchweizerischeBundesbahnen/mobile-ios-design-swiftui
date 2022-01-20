//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    private let startView = SBBOnboardingTitleView(image: Image("Onboarding_Start"), title: Text("Welcome to the Design System Mobile Demo App"))
    private let endView = SBBOnboardingTitleView(image: Image("Onboarding_Start"), title: Text("We hope you enjoy exploring the Design System Mobile elements."))

    var body: some View {
        SBBOnboardingView(state: $viewModel.onboardingState, currentCardIndex: $viewModel.currentOnboardingCardIndex, startView: startView, endView: endView) {
            SBBOnboardingCardView(image: Image("Onboarding_Card1"), title: Text("Design System Mobile"), text: Text("With Design System Mobile, all SBB apps are recognisable as such at first glance.")) {
                Button(action: {
                    guard let url = URL(string: "https://digital.sbb.ch/en/mobile"),
                        UIApplication.shared.canOpenURL(url) else {
                        return
                    }
                    UIApplication.shared.open(url)
                }) {
                    Text("UX Documentation")
                }
                    .buttonStyle(SBBSecondaryButtonStyle())
            }
            SBBOnboardingCardView(image: Image("Onboarding_Card2"), title: Text("iOS and Android Libraries"), text: Text("Libraries for iOS and Android allow developers to quickly create user interfaces according to SBB standards.")) {
                Button(action: {
                    guard let url = URL(string: "https://github.com/SchweizerischeBundesbahnen/mobile-ios-design-swiftui"),
                        UIApplication.shared.canOpenURL(url) else {
                        return
                    }
                    UIApplication.shared.open(url)
                }) {
                    Text("GitHub")
                }
                    .buttonStyle(SBBSecondaryButtonStyle())
            }
            SBBOnboardingCardView(image: Image("Onboarding_Card3"), title: Text("Using the Libraries"), text: Text("The libraries are developed and maintained by the DSRVs AppBakery and UX. Please get in touch with us now.")) {
                Button(action: {
                    guard let url = URL(string: "https://sbb.sharepoint.com/sites/app-bakery/SitePages/Kontakt.aspx"),
                        UIApplication.shared.canOpenURL(url) else {
                        return
                    }
                    UIApplication.shared.open(url)
                }) {
                    Text("Contact us")
                }
                    .buttonStyle(SBBSecondaryButtonStyle())
            }
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
