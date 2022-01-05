//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that is used to inform users about app functionality and guide them through it (typically shown upon first app launch). SBBOnboardingView always shows a ``SBBOnboardingTitleView`` at the start and at the end of the onboarding process and a customizable number of ``SBBOnboardingCardView``s inbetween.
 
 ## Overview
 You can create a SBBOnboardingView by specifying the ``SBBOnboardingState``, a binding to the current card index, a start and end ``SBBOnboardingTitleView`` as well as an Array of ``SBBOnboardingCardView``s. You typically use an own ViewModel for onboardingState handling and persistence. You typically use an if-else condition to alternatively display your main ContentView or the SBBOnboardingView depending on the onboardingState:
 ```swift
 // You typically use a ViewModel for onboardingState handling and persistence
 @State var onboardingState: SBBOnboardingState = .startView
 @State var currentOnboardingCardIndex: Int = 0
 
 var body: some View {
    if {
        ContentView()
    } else {
        SBBOnboardingView(state: $onboardingState, currentCardIndex: $currentOnboardingCardIndex, startView: SBBOnboardingTitleView(image: Image("ImageStart"), title: Text("Willkommen")), endView: SBBOnboardingTitleView(image: Image("ImageEnd"), title: Text("Los geht's")), content: [SBBOnboardingCardView(image: Image("ImageCard"), title: Text("Card with additional custom content"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))])
    }
 }
 ```
 ![SBBOnboardingTitleView](SBBOnboardingTitleView)
 ![SBBOnboardingCardView](SBBOnboardingCardView)
 */
public struct SBBOnboardingView: View {
    
    @ObservedObject private var viewModel: OnboardingViewModel
    private var startView: OnboardingTitleWrapperView
    private var endView: OnboardingTitleWrapperView
    
    /**
     Returns a SBBOnboardingView with a starting and ending ``SBBOnboardingTitleView`` and a single ``SBBOnboardingCardView`` inbetween.
     
     - Parameters:
        - state: The current state of the onboarding process. This state typically needs to be persisted (e.g. in UserDefaults).
        - startView: The SBBOnboardingTitleView used as a welcome screen.
        - endView: The SBBOnboardingTitleView used as a final onboarding screen.
        - content: A single SBBOnboardingCardView to be shown between the startView and the endView.
     */
    public init(state: Binding<SBBOnboardingState>, startView: SBBOnboardingTitleView, endView: SBBOnboardingTitleView, @ViewBuilder content: @escaping () -> SBBOnboardingCardView) {
        let viewModel = OnboardingViewModel(state: state, currentCardIndex: .constant(0), cardViews: [content()])
        self.viewModel = viewModel
        self.startView = OnboardingTitleWrapperView(viewModel: viewModel, sbbOnboardingTitleView: startView)
        self.endView = OnboardingTitleWrapperView(viewModel: viewModel, sbbOnboardingTitleView: endView)
    }
    
    /**
     Returns a SBBOnboardingView with a starting and ending ``SBBOnboardingTitleView`` and multiple ``SBBOnboardingCardView``s inbetween.
     
     - Parameters:
        - state: The current state of the onboarding process. This state typically needs to be persisted (e.g. in UserDefaults).
        - startView: The SBBOnboardingTitleView used as a welcome screen.
        - endView: The SBBOnboardingTitleView used as a final onboarding screen.
        - content: Multiple SBBOnboardingCardViews to be shown between the startView and the endView (the user can swipe through them).
     */
    public init(state: Binding<SBBOnboardingState>, currentCardIndex: Binding<Int>, startView: SBBOnboardingTitleView, endView: SBBOnboardingTitleView, @ArrayBuilder<SBBOnboardingCardView> content: () -> [SBBOnboardingCardView]) {
        let viewModel = OnboardingViewModel(state: state, currentCardIndex: currentCardIndex, cardViews: content())
        self.viewModel = viewModel
        self.startView = OnboardingTitleWrapperView(viewModel: viewModel, sbbOnboardingTitleView: startView)
        self.endView = OnboardingTitleWrapperView(viewModel: viewModel, sbbOnboardingTitleView: endView)
    }
        
    public var body: some View {
        Group {
            if viewModel.state == .startView {
                startView
            } else if viewModel.state == .endView {
                endView
            } else if viewModel.state == .cardsView {
                OnboardingCardsWrapperView(viewModel: viewModel)
            }
        }
            .navigationBarTitle("Hidden Title")   // Navigation Bar Title needs to be set for ignoring Safe Area Edges
            .navigationBarHidden(true)
    }
}

struct SBBOnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SBBOnboardingView(state: .constant(.startView), startView: FakeSBBOnboardingTitleViews.start, endView: FakeSBBOnboardingTitleViews.end) {
                SBBOnboardingCardView() {
                    EmptyView()
                }
            }
                .previewDisplayName("StartView Light")
            SBBOnboardingView(state: .constant(.startView), currentCardIndex: .constant(0), startView: FakeSBBOnboardingTitleViews.start, endView: FakeSBBOnboardingTitleViews.end) {
                SBBOnboardingCardView() {
                    EmptyView()
                }
                SBBOnboardingCardView() {
                    EmptyView()
                }
            }
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
