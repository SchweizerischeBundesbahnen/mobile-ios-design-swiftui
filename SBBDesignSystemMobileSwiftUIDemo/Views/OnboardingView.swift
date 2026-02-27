//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct OnboardingView: View {
        
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        SBBOnboardingWrapper(state: viewModel.onboardingState,
                             currentCard: viewModel.currentOnboardingCard,
                             currentCardIndex: viewModel.currentOnboardingCardIndex, nbCards: 3, startView: {
            SBBOnboardingWrapperTitleView(image: Image("Onboarding_Start"), title: Text("Welcome to the Design System Mobile Demo App"), buttonView: {
                Button(action: {
                    withAnimation {
                        viewModel.onboardingState = .cards
                    }
                }) {
                    Text("Start App tour")
                }
                .buttonStyle(SBBPrimaryButtonStyle())
            })
        }, endView: {
            SBBOnboardingWrapperTitleView(image: Image("Onboarding_Start"), title: Text("We hope you enjoy exploring the Design System Mobile elements."), buttonView: {
                Button(action: {
                    withAnimation {
                        viewModel.onboardingState = .hidden
                    }
                }) {
                    Text("End App tour")
                }
                .buttonStyle(SBBPrimaryButtonStyle())
            })
        }, cardBuilder: { onboardingCard, geometrySize in
            switch onboardingCard {
            case .dsm:
                SBBOnboardingWrapperCardView(image: Image("Onboarding_Card1"), title: Text("Design System Mobile"), size: geometrySize, buttonLabel: "UX Documentation", buttonAction: {
                    guard let url = URL(string: "https://digital.sbb.ch/en/mobile"),
                        UIApplication.shared.canOpenURL(url) else {
                        return
                    }
                    UIApplication.shared.open(url)
                }, onNext: { viewModel.onNext(.github) }) {
                        Text("With Design System Mobile, all SBB apps are recognisable as such at first glance.")
                }
            case .github:
                SBBOnboardingWrapperCardView(image: Image("Onboarding_Card2"), title: Text("iOS and Android Libraries"), size: geometrySize, buttonLabel: "GitHub", buttonAction: {
                    guard let url = URL(string: "https://github.com/SchweizerischeBundesbahnen/mobile-ios-design-swiftui"),
                        UIApplication.shared.canOpenURL(url) else {
                        return
                    }
                    UIApplication.shared.open(url)
                }, onNext: { viewModel.onNext(.contact) }) {
                    Text("Libraries for iOS and Android allow developers to quickly create user interfaces according to SBB standards.")
                }
            case .contact:
                SBBOnboardingWrapperCardView(image: Image("Onboarding_Card3"), title: Text("Using the Libraries"), size: geometrySize, buttonLabel: "Contact us", buttonAction: {
                    guard let url = URL(string: "https://sbb.sharepoint.com/sites/app-bakery/SitePages/Kontakt.aspx"),
                        UIApplication.shared.canOpenURL(url) else {
                        return
                    }
                    UIApplication.shared.open(url)
                }, onNext: { viewModel.onNext(nil) }) {
                    Text("The libraries are developed and maintained by the DSRVs AppBakery and UX. Please get in touch with us now.")
                }
            }
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView()
                .previewDisplayName("Light StartView")
                .environmentObject(OnboardingViewModel(onboardingState: .start))
            OnboardingView()
                .previewDisplayName("Light CardsView")
                .environmentObject(OnboardingViewModel(onboardingState: .cards))
            OnboardingView()
                .previewDisplayName("Dark CardsView")
                .environment(\.colorScheme, .dark)
                .environmentObject(OnboardingViewModel(onboardingState: .cards))
            OnboardingView()
                .previewDisplayName("Light EndView")
                .environmentObject(OnboardingViewModel(onboardingState: .end))
        }
    }
}
