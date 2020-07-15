//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingCardsView: View {
    
    @Binding var onboardingState: SBBOnboardingState
    @State var currentCardIndex: Int = 0
    
    let cardViews: [SBBOnboardingCardView]
    
    var body: some View {
        VStack(spacing: 0) {
            if currentCardIndex < cardViews.count {
                GeometryReader { geometry in
                    ZStack {
                        self.cardViews[self.currentCardIndex]
                    }
                        .padding(.top, geometry.safeAreaInsets.top)
                        .background(SBBColor.red.edgesIgnoringSafeArea(.top))
                        .cornerRadius(16, corners: .bottomLeft)
                        .cornerRadius(16, corners: .bottomRight)
                        .edgesIgnoringSafeArea(.top)
                }
            }
            VStack(spacing: 16) {
                HStack {
                    Button(action: {
                        self.showPreviousCard()
                    }) {
                        HStack {
                            Image("chevron_small_right_45_small", bundle: Helper.bundle)
                                .rotationEffect(Angle(degrees: 180))
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(SBBColor.border))
                        }
                        
                    }
                    Spacer()
                    SBBPaginationView(currentPageIndex: $currentCardIndex, numberOfPages: cardViews.count)
                    Spacer()
                    Button(action: {
                        self.showNextCard()
                    }) {
                        HStack {
                            Image("chevron_small_right_45_small", bundle: Helper.bundle)
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(SBBColor.border))
                        }
                        
                    }
                }
                Button(action: {
                    self.onboardingState = .hidden
                }) {
                    Text("Rundgang abbrechen")
                }
                    .buttonStyle(SBBTertiarySmallButtonStyle())
            }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
        }
            .foregroundColor(SBBColor.textBlack)
            .background(SBBColor.background.edgesIgnoringSafeArea(.all))
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
