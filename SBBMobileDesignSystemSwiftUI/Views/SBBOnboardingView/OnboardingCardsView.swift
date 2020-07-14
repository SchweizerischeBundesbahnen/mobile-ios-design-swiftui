//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingCardsView: View {
    
    @Binding var onboardingState: SBBOnboardingState
    @State var currentCardIndex: Int = 0
    
    let cardViews: [SBBOnboardingCardView]
    
    var body: some View {
        VStack {
            if currentCardIndex < cardViews.count {
                cardViews[currentCardIndex]
            }
            HStack {
                Button(action: {
                    self.showPreviousCard()
                }) {
                    Text("zurück")
                }
                Text("\(currentCardIndex + 1) von \(cardViews.count)")
                Button(action: {
                    self.showNextCard()
                }) {
                    Text("weiter")
                }
            }
            Button(action: {
                self.onboardingState = .hidden
            }) {
                Text("Rundgang abbrechen")
            }
        }
    }
    
    private func showPreviousCard() {
        if currentCardIndex == 0 {
            onboardingState = .startView
        } else {
            currentCardIndex -= 1
        }
    }
    
    private func showNextCard() {
        if currentCardIndex == cardViews.count - 1 {
            onboardingState = .endView
        } else {
            currentCardIndex += 1
        }
    }
}

struct OnboardingCardsView_Previews: PreviewProvider {
    
    static let cardView = SBBOnboardingCardView(image: Image(systemName: "car"), title: Text("Test title"), text: Text("Test text"))
    static let cardViews = [cardView, cardView]
    
    static var previews: some View {
        Group {
            OnboardingCardsView(onboardingState: .constant(.startView), cardViews: cardViews)
                .previewDisplayName("Light")
            OnboardingCardsView(onboardingState: .constant(.startView), cardViews: cardViews)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
