//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that is used to inform users about app functionality and guide them through it (typically shown upon first app launch). It can consist of a start view, restart view, update view, settings view, end view and a builder for the cards views.
 The state is given by an ``SBBOnboardingWrapperState``, which specify which view is then displayed. For the cards view, the state of it is given by a ``Card: Equatable`` which can be an enum, and by a index ``Int`` which is used for the pagination.
 This View is purely a wrapper - the state management (going from one state to another, one card to another) is left to the developer.
 
 
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
        
    private var state: SBBOnboardingWrapperState
    private var currentCard: Card
    private var currentCardIndex: Int
    private var nbCards: Int
    
    private var startView: StartView?
    private var restartView: RestartView?
    private var updateView: UpdateView?
    private var settingsView: SettingsView?
    private var endView: EndView?
    private var cardBuilder: (Card, CGSize) -> CardView
    
    /**
     Returns a SBBOnboardingWrapper. It is purely a wrapper for the onboarding. Typically, it is composed of `SBBTitleView` for the start, restart, update and end view and `SBBCardView` for the cards view. The state management - how we get from one view to another - is not part of this view and should be implemented in the title views. For the cards view, it is typically done in the `onNext` method parameter - we set the new card and card index in this method, as well as any custom actions that need to be done on a transition.
     
     - Parameters:
        - state: The current state of the  process. This state typically needs to be persisted (e.g. in UserDefaults).
        - currentCard: The current card of the process. Typically a case from an enum.
        - currentCardIndex: The current card index of the process.
        - nbCars: The number of cards.
        - startView: (optional) The view used as a welcome screen. Typically `SBBTitleView`.
        - restartView: (optional) The view used when looking at the onboarding again.
        - updateView: (optional) The view used when a new feature is added. Typically `SBBTitleView`.
        - settingsView: (optional) The view to display settings if any. Typically `SBBOnboardingSettingsView`.
        - endView: (optional) The view used as a final screen. Typically `SBBTitleView`.
        - cardBuilder: The view builder to create the cards from `currentCard`.
     */
    public init(state: SBBOnboardingWrapperState, currentCard: Card, currentCardIndex: Int, nbCards: Int, @ViewBuilder startView: () -> StartView = { EmptyView() }, @ViewBuilder restartView: () -> RestartView = { EmptyView() }, @ViewBuilder updateView: () -> UpdateView = { EmptyView() }, @ViewBuilder settingsView: () -> SettingsView = { EmptyView() }, @ViewBuilder endView: () -> EndView = { EmptyView() }, @ViewBuilder cardBuilder: @escaping (Card, CGSize) -> CardView) {
        self.state = state
        self.currentCard = currentCard
        self.currentCardIndex = currentCardIndex
        self.nbCards = nbCards
        self.cardBuilder = cardBuilder
        self.startView = maybeInit(startView)
        self.restartView = maybeInit(restartView)
        self.updateView = maybeInit(updateView)
        self.settingsView = maybeInit(settingsView)
        self.endView = maybeInit(endView)
    }
    
    @available(*, deprecated, message: "state, currentCard and currentCardIndex are not Bindings anymore. cardBuilder takes parameters (Card, CGSize) instead of only (Card).")
    public init(state: Binding<SBBOnboardingWrapperState>, currentCard: Binding<Card>, currentCardIndex: Binding<Int>, nbCards: Int, @ViewBuilder startView: () -> StartView = { EmptyView() }, @ViewBuilder restartView: () -> RestartView = { EmptyView() }, @ViewBuilder updateView: () -> UpdateView = { EmptyView() }, @ViewBuilder settingsView: () -> SettingsView = { EmptyView() }, @ViewBuilder endView: () -> EndView = { EmptyView() }, @ViewBuilder cardBuilder: @escaping (Card) -> CardView) {
        self.state = state.wrappedValue
        self.currentCard = currentCard.wrappedValue
        self.currentCardIndex = currentCardIndex.wrappedValue
        self.nbCards = nbCards
        self.cardBuilder = { card, _ in
            cardBuilder(card)
        }
        self.startView = maybeInit(startView)
        self.restartView = maybeInit(restartView)
        self.updateView = maybeInit(updateView)
        self.settingsView = maybeInit(settingsView)
        self.endView = maybeInit(endView)
    }
    
    private func maybeInit<T>(_ view: () -> T) -> T? {
        let view = view()
        return view is EmptyView ? nil : view
    }
    
    private var pagination: some View {
        VStack {
            HStack {
                SBBPaginationView(currentPageIndex: currentCardIndex, numberOfPages: nbCards, selectedDoubleSize: true)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16)
            .padding(.vertical, 8)
            Spacer()
        }
    }
    
    private func stateView<T: View>(_ state: SBBOnboardingWrapperState, _ view: T?) -> some View {
        return VStack {
            if let view {
                view
            } else {
                SBBMessage(title: Text("Onboarding error"), text: Text("Onboarding \(state.rawValue) does not exist."), imageType: .error)
            }
        }
    }

    public var body: some View {
        Group {
            if state == .start {
                stateView(.start, startView)
                    .transition(.backslide)
            } else if state == .restart {
                stateView(.restart, restartView)
                    .transition(.backslide)
            } else if state == .update {
                stateView(.update, updateView)
                    .transition(.backslide)
            } else if state == .cards {
                ZStack {
                    GeometryReader { geometry in
                        cardBuilder(currentCard, geometry.size)
                            .transition(.backslide)
                    }
                    
                    if nbCards != 1 {
                        pagination
                            .accessibilitySortPriority(2)
                    }
                }
                .foregroundColor(.sbbColor(.textBlack))
                .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.all))
                .transition(.backslide)
            } else if state == .settings {
                stateView(.settings, settingsView)
                    .transition(.backslide)
            } else if state == .end {
                stateView(.end, endView)
                    .transition(.backslide)
            }
        }
        .navigationBarTitle("Hidden Title")   // Navigation Bar Title needs to be set for ignoring Safe Area Edges
        .navigationBarHidden(true)
    }
}

#Preview {
    SBBOnboardingWrapper(state: .start, currentCard: 1, currentCardIndex: 1, nbCards: 1, startView: {
        SBBOnboardingWrapperTitleView(image: Image("Onboarding_Luc", bundle: Helper.bundle), title: Text("Welcome!"), subtitle: Text("Welcome to your app tour."), buttonView: {
            Button(action: {}) {
                Text("Start")
            }.buttonStyle(SBBPrimaryButtonStyle())
        })
    }, endView: {}, cardBuilder: { _, _ in })
}
