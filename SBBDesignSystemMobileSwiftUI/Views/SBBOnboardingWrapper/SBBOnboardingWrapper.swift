//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that is used to inform users about app functionality and guide them through it (typically shown upon first app launch). It can consist of a start view, restart view, update view, settings view, end view and a builder for the cards views.
 The state is given by an ``SBBOnboardingWrapperState``, which specify which view is then displayed. For the cards view, the state of it is given by a ``Card: Equatable`` which can be an enum, and by a index ``Int`` which is used for the pagination.
 
 
 ## Overview
You can create a SBBOnboardingWrapper by specifying all the views, as well as the card views.
 ```swift
 // You typically use a ViewModel for overviewState handling and persistence
 @State var state: SBBOnboardingWrapperState = .start
 @State var currentCard: OverviewCard = .card1
 @State var currentCardIndex: Int = 0
 
 var body: some View {
 SBBOnboardingWrapper(state: $viewModel.onboardingState, currentCard: $viewModel.currentOnboardingCard, currentCardIndex: $viewModel.currentOnboardingCardIndex, nbCards: viewModel.nbCards, startView: {
        // start view here, typically a ``SBBTitleView``
     }, restartView: {
         // rstart view here, typically a ``SBBTitleView``
     }, updateView: {
         // update view here, typically a ``SBBTitleView``
     }, settingsView: {
         // update view here
     }, endView: {
         // end view here, typically a ``SBBTitleView``
     }, cardBuilder: { card in
         switch card {
         case .card1:
            // card view here, typically a ``SBBCardView``
         case .card2:
            // card view here, typically a ``SBBCardView``
             ...
         }
     })
 }
 ```
 ![SBBOnboardingWrapper](SBBOnboardingWrapper)
 ![SBBOnboardingWrapperCard](SBBOnboardingWrapperCard)
 */

public struct SBBOnboardingWrapper<Card: Equatable, CardView: View, StartView: View, RestartView: View, UpdateView: View, SettingsView: View, EndView: View>: View {
        
    @Environment(\.sizeCategory) private var sizeCategory
        
    @Binding private var state: SBBOnboardingWrapperState
    @Binding private var currentCard: Card
    @Binding private var currentCardIndex: Int
    private var nbCards: Int
    
    private var startView: StartView
    private var restartView: RestartView
    private var updateView: UpdateView
    private var settingsView: SettingsView
    private var endView: EndView
    private var cardBuilder: (Card) -> CardView
    
    /**
     Returns a SBBOnboardingWrapper.
     
     - Parameters:
        - state: The current state of the  process. This state typically needs to be persisted (e.g. in UserDefaults).
        - currentCard: The current card of the process. Typically a case from an enum.
        - currentCardIndex: The current card index of the process.
        - nbCars: The number of cards.
        - startView: The view used as a welcome screen.
        - restartView: (optional) The view used when looking at the overview again.
        - updateView: (optional) The view used when a new feature is added.
        - settingsView: (optional) The view to display settings if any.
        - endView: The view used as a final screen.
        - cardBuilder: The view builder to create the cards from `currentCard`.
     */
    public init(state: Binding<SBBOnboardingWrapperState>, currentCard: Binding<Card>, currentCardIndex: Binding<Int>, nbCards: Int, @ViewBuilder startView: () -> StartView, @ViewBuilder restartView: () -> RestartView = { EmptyView() }, @ViewBuilder updateView: () -> UpdateView = { EmptyView() }, @ViewBuilder settingsView: () -> SettingsView = { EmptyView() }, @ViewBuilder endView: () -> EndView, @ViewBuilder cardBuilder: @escaping (Card) -> CardView) {
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
        Group {
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
                        .transition(.backslide)
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
        .navigationBarTitle("Hidden Title")   // Navigation Bar Title needs to be set for ignoring Safe Area Edges
        .navigationBarHidden(true)
    }
}

#Preview {
    SBBOnboardingWrapper(state: .constant(.start), currentCard: .constant(1), currentCardIndex: .constant(1), nbCards: 1, startView: {
        SBBTitleView(image: Image("Onboarding_Luc", bundle: Helper.bundle), title: Text("Welcome!"), subtitle: Text("Welcome to your app tour."), buttonView: {
            Button(action: {}) {
                Text("Start")
            }.buttonStyle(SBBPrimaryButtonStyle())
        })
    }, endView: {}, cardBuilder: { _ in })
}
