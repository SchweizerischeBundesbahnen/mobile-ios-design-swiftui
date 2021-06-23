//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

class OnboardingViewDemoModel: ObservableObject {
    @Published var numberOfCards: Int = 3
    var minimumNumberOfCards: Int {
        return (withCustomButton ? 1 : 0) + (withCustomCard ? 1 : 0) + (withCustomAction ? 1 : 0)
    }
    @Published var withCustomButton: Bool = false {
        didSet { updateMinimumNumberOfCards() }
    }
    @Published var withCustomCard: Bool = false {
        didSet { updateMinimumNumberOfCards() }
    }
    @Published var withCustomAction: Bool = false {
        didSet { updateMinimumNumberOfCards() }
    }

    private func updateMinimumNumberOfCards() {
        if numberOfCards < minimumNumberOfCards {
            numberOfCards = minimumNumberOfCards
        }
    }
}

struct OnboardingViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var onboardingState: SBBOnboardingState = .hidden
    @State private var currentOnboardingCardIndex: Int = 0
    @State private var showingAlert = false
    
    @ObservedObject private var viewModel = OnboardingViewDemoModel()

    private let startView = SBBOnboardingTitleView(image: Image("Onboarding_Luc"), title: Text("Willkommen bei SBB DSM"))
    private let endView = SBBOnboardingTitleView(image: Image("Onboarding_Gang"), title: Text("Wir wünschen Ihnen eine gute Fahrt mit SBB DSM"))

    var body: some View {
        Group {
            if onboardingState == .hidden {
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            SBBFormGroup(title: "Number of Cards") {
                                Stepper("\(self.viewModel.numberOfCards)", value: self.$viewModel.numberOfCards, in: 1...10)
                                    .sbbFont(.body)
                                .padding(16)
                            }
                            SBBFormGroup(title: "Customize Content") {
                                SBBCheckBox(isOn: self.$viewModel.withCustomButton, label: "Card with additional custom content")
                                SBBCheckBox(isOn: self.$viewModel.withCustomAction, label: "Card with custom action")
                                SBBCheckBox(isOn: self.$viewModel.withCustomCard, label: "Custom Card", showBottomLine: false)
                            }
                            Spacer()
                        }
                    }
                    Button(action: {
                        self.currentOnboardingCardIndex = 0
                        self.onboardingState = .startView
                    }) {
                        Text("Show Onboarding View")
                    }
                        .buttonStyle(SBBPrimaryButtonStyle())
                }
                    .padding(16)
                    .navigationBarTitle("Onboarding")
                    .sbbStyle()
            } else {
                SBBOnboardingView(state: $onboardingState, currentCardIndex: $currentOnboardingCardIndex, startView: startView, endView: endView, content: createCardViews)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Custom Action"), message: Text("This alert is presented as a custom executable action on card disappear."), dismissButton: .default(Text("Got it!")))
                    }
            }
        }
             .colorScheme(colorScheme)
    }
    
    
    
    private func createCardViews() -> [SBBOnboardingCardView] {
        let text = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
        
        var cardViews = [SBBOnboardingCardView]()
        if viewModel.withCustomButton {
            cardViews.append(SBBOnboardingCardView(image: Image("Onboarding_Train"), title: Text("Card with additional custom content"), text: text) {
                FakeSBBOnboardingCardViewCustomButton()
            })
        }
        if viewModel.withCustomAction {
            cardViews.append(SBBOnboardingCardView(image: Image("Onboarding_Train"), title: Text("Card with custom action"), text: text, actionOnCardDisappear:{
                self.showingAlert = true
            }))
        }
        if viewModel.withCustomCard {
            cardViews.append(SBBOnboardingCardView {
                HStack {
                    Spacer()
                    VStack {
                        Text("Custom Card")
                        Spacer()
                    }
                    Spacer()
                }
            })
        }
        
        if viewModel.numberOfCards > viewModel.minimumNumberOfCards {
            for n in 1...(viewModel.numberOfCards - viewModel.minimumNumberOfCards) {
                cardViews.append(SBBOnboardingCardView(image: Image("Onboarding_Train"), title: Text("Card \(n)"), text: text))
            }
        }
        
        return cardViews
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
            Text("Diese Funktion ausprobieren")
        }
            .buttonStyle(SBBSecondaryButtonStyle())
            .sheet(isPresented: $showingModalView, content: {
                SBBModalView(title: Text("Funktion Ausprobieren"), isPresented: self.$showingModalView) {
                    VStack {
                        Spacer()
                        Text("Your content here")
                        Spacer()
                    }
                }
                    .sbbStyle()
            })
    }
}
