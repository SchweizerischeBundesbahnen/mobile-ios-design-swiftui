//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

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
    @State private var overviewState: SBBOnboardingWrapperState = .hidden
    @State private var currentOnboardingCardIndex: Int = 0
    @State private var showingAlert = false
    @State private var showTrySheet = false
    
    @ObservedObject private var viewModel = OnboardingViewDemoModel()

    var body: some View {
        Group {
            if overviewState == .hidden {
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            SBBFormGroup(title: "Number of Cards") {
                                Stepper("\(self.viewModel.numberOfCards)", value: self.$viewModel.numberOfCards, in: 1...10)
                                    .sbbFont(.medium_light)
                                .padding(16)
                            }
                            SBBFormGroup(title: "Customize Content") {
                                SBBCheckBox(isOn: self.$viewModel.withCustomButton, text: Text("Card with additional custom content"))
                                SBBCheckBox(isOn: self.$viewModel.withCustomAction, text: Text("Card with custom action"))
                                SBBCheckBox(isOn: self.$viewModel.withCustomCard, text: Text("Custom Card"), showBottomLine: false)
                            }
                            Spacer()
                        }
                    }
                    Button(action: {
                        self.currentOnboardingCardIndex = 0
                        self.overviewState = .start
                    }) {
                        Text("Show Onboarding")
                    }
                    .buttonStyle(SBBSecondaryButtonStyle())
                }
                    .sbbScreenPadding()
                    .navigationBarTitle("Onboarding")
                    .sbbStyle()
                    .sbbBackButtonStyle()
            } else {
                SBBOnboardingWrapper(state: overviewState, currentCard: currentOnboardingCardIndex, currentCardIndex: currentOnboardingCardIndex, nbCards: viewModel.numberOfCards, startView: {
                    SBBOnboardingWrapperTitleView(image: Image("Onboarding_Luc"), title: Text("Willkommen"), subtitle: Text("Willkommen zum Rundgang."), buttonView: {
                        Button(action: {
                            withAnimation {
                                overviewState = .cards
                            }
                        }) {
                            Text("Start")
                        }
                        .buttonStyle(SBBPrimaryButtonStyle())
                    })
                }, endView: {
                    SBBOnboardingWrapperTitleView(image: Image("Onboarding_Gang"), title: Text("Gute Fahrt"), subtitle: Text("Wir wünschen Ihnen eine gute Fahrt mit SBB DSM."), buttonView: {
                        Button(action: {
                            withAnimation {
                                overviewState = .hidden
                            }
                        }) {
                            Text("End")
                        }
                        .buttonStyle(SBBPrimaryButtonStyle())
                    })
                }, cardBuilder: { card, geometrySize in
                    if card % 2 == 1 {
                        createCardView(card, viewModel.withCustomCard, viewModel.withCustomAction, viewModel.withCustomButton, geometrySize)
                    } else {
                        createCardView(card, viewModel.withCustomCard, viewModel.withCustomAction, viewModel.withCustomButton, geometrySize)
                    }
                })
                .sheet(isPresented: $showTrySheet, content: {
                    SBBModalView(title: Text("Funktion Ausprobieren"), isPresented: self.$showTrySheet) {
                        VStack {
                            Spacer()
                            Text("Your content here")
                            Spacer()
                        }
                    }
                        .sbbStyle()
                })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Custom Action"), message: Text("This alert is presented as a custom executable action on card disappear."), dismissButton: .default(Text("Got it!")))
                }
            }
        }
             .colorScheme(colorScheme)
    }
    
    @ViewBuilder
    private func createCardView(_ card: Int, _ customCard: Bool, _ customAction: Bool, _ customButton: Bool, _ geometrySize: CGSize) -> some View {
        if card == 0, customCard {
            VStack {
                Spacer()
                Text("Custom card")
                
                Button(action: {
                    currentOnboardingCardIndex += 1
                    if card == viewModel.numberOfCards - 1 {
                        overviewState = .end
                    }
                }) {
                    Text("Weiter")
                }
                .buttonStyle(SBBSecondaryButtonStyle())
                
                if customButton {
                    Button(action: {
                        withAnimation {
                            showTrySheet = true
                        }
                    }) {
                        Text("Ausprobieren")
                    }
                    .buttonStyle(SBBPrimaryButtonStyle())
                }
                Spacer()
            }
            .sbbScreenPadding()
            .onDisappear {
                if customAction {
                    showingAlert = true
                }
            }
        } else if customButton {
            SBBOnboardingWrapperCardView(image: Image("Onboarding_Card2"), title: Text("Card"), size: geometrySize, showTrySheet: $showTrySheet, onNext: {
                currentOnboardingCardIndex += 1
                if card == viewModel.numberOfCards - 1 {
                    overviewState = .end
                }
            }) {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            }
            .onDisappear {
                if card == 0 && customAction {
                    showingAlert = true
                }
            }
        } else {
            SBBOnboardingWrapperCardView(image: Image("Onboarding_Card2"), title: Text("Card"), size: geometrySize, onNext: {
                currentOnboardingCardIndex += 1
                if card == viewModel.numberOfCards - 1 {
                    overviewState = .end
                }
            }) {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            }
            .onDisappear {
                if card == 0 && customAction {
                    showingAlert = true
                }
            }
        }
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
