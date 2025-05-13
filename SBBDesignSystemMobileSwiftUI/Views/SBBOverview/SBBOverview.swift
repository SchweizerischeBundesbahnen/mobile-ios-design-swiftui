//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

public struct SBBOverview<Card: Equatable, CardView: View, StartView: View, RestartView: View, UpdateView: View, SettingsView: View, EndView: View>: View {
        
    @Environment(\.sizeCategory) private var sizeCategory
    
    @State private var width: CGFloat = .zero
    
    @Binding private var state: SBBOverviewState
    @Binding private var currentCard: Card
    @Binding private var currentCardIndex: Int
    private var nbCards: Int
    
    private var startView: StartView
    private var restartView: RestartView
    private var updateView: UpdateView
    private var settingsView: SettingsView
    private var endView: EndView
    private var cardBuilder: (Card) -> CardView
    
    public init(state: Binding<SBBOverviewState>, currentCard: Binding<Card>, currentCardIndex: Binding<Int>, nbCards: Int, @ViewBuilder startView: () -> StartView, @ViewBuilder restartView: () -> RestartView = { EmptyView() }, @ViewBuilder updateView: () -> UpdateView = { EmptyView() }, @ViewBuilder settingsView: () -> SettingsView = { EmptyView() }, @ViewBuilder endView: () -> EndView, @ViewBuilder cardBuilder: @escaping (Card) -> CardView) {
        self._state = state
        self._currentCard = currentCard
        self._currentCardIndex = currentCardIndex
        self.nbCards = nbCards
        self.cardBuilder = cardBuilder
        self.startView = startView()
        self.restartView = restartView()
        self.updateView = updateView()
        self.settingsView = settingsView()
        self.endView = endView()
    }
    
    private var pagination: some View {
        VStack {
            HStack {
                SBBPaginationView(currentPageIndex: $currentCardIndex, numberOfPages: nbCards)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8
            )
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16)
            
            Spacer()
        }
    }

    public var body: some View {
        // WORKAROUND: we need the width to give it to the OnboardingCardView to avoid the animation when the text adjust to the size (text, lineLimit, minScaleFactor) in landscape mode
        ZStack {
            HStack {
                Spacer()
                    .frame(height: .zero)
                    .viewWidth($width)
            }
            if state == .start {
                startView
                    .transition(.backslide)
            } else if state == .restart {
                restartView
                    .transition(.backslide)
            } else if state == .update {
                updateView
                    .transition(.backslide)
            } else if state == .cards {
                ZStack {
                    cardBuilder(currentCard)
                    pagination
                }
                .transition(.backslide)
                .foregroundColor(.sbbColor(.textBlack))
                .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.all))
            } else if state == .settings {
                settingsView
                    .transition(.backslide)
            } else if state == .end {
                endView
                    .transition(.backslide)
            }
        }
    }
}

//#Preview {
//    OnboardingView()
//        .environmentObject(FakeOnboardingViewModel(onboardingState: .start) as OnboardingViewModel)
//}
//
//#Preview {
//    OnboardingView()
//        .environmentObject(FakeOnboardingViewModel(onboardingState: .restart) as OnboardingViewModel)
//}
//
//#Preview {
//    OnboardingView()
//        .environmentObject(FakeOnboardingViewModel(onboardingState: .cards, currentOnboardingCard: .stop) as OnboardingViewModel)
//}
//
//#Preview {
//    OnboardingView()
//        .environmentObject(FakeOnboardingViewModel(onboardingState: .settings) as OnboardingViewModel)
//}
//
//#Preview {
//    OnboardingView()
//        .environmentObject(FakeOnboardingViewModel(onboardingState: .end) as OnboardingViewModel)
//}
