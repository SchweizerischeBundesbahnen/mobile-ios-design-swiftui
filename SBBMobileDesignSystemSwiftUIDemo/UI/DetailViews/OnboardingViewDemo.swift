//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct OnboardingViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var onboardingState: SBBOnboardingState = .hidden
    
    private let startView = SBBOnboardingTitleView(image: Image("TODO"), title: Text("Willkommen bei Ihrer SBB App"))
    private let endView = SBBOnboardingTitleView(image: Image("TODO"), title: Text("Starten"))

    var body: some View {
        Group {
            if onboardingState == .hidden {
                Button(action: {
                    self.onboardingState = .startView
                }) {
                    Text("Show Onboarding View")
                }
                    .buttonStyle(SBBPrimaryButtonStyle())
            } else {
                SBBOnboardingView(state: $onboardingState, startView: startView, endView: endView) {
                    SBBOnboardingCardView(image: Image("Onboarding_Train"), title: Text("Card 1"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."), actionOnCardDisappear:{
                        print("Action on card disappear.")
                    })
                    SBBOnboardingCardView(image: Image("Onboarding_Train"), title: Text("Card 2"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")) {
                            FakeSBBOnboardingCardViewCustomButton()
                    }
                    SBBOnboardingCardView {
                        Text("Custom Card")
                    }
                }
            }
        }
             .colorScheme(colorScheme)
    }
}

struct OnboardingViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingViewDemo(colorScheme: .constant(.light))
            OnboardingViewDemo(colorScheme: .constant(.dark))
        }
    }
}

struct FakeSBBOnboardingCardViewCustomButton: View {

    @State private var showingModalView = false
    
    var body: some View {
        Button(action: {
            self.showingModalView = true
        }) {
            Text("Try it out")
        }
            .buttonStyle(SBBSecondaryButtonStyle())
            .sheet(isPresented: $showingModalView, content: {
                SBBModalView(title: Text("Try it out - example"), isPresented: self.$showingModalView) {
                    VStack {
                        Spacer()
                        Text("Your content here")
                        Spacer()
                    }
                }
            })
    }
}
