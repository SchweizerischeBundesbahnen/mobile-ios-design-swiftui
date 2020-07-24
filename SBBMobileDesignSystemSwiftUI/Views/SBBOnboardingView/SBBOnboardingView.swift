//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBOnboardingView: View {
    
    @ObservedObject private var viewModel: OnboardingViewModel
    private var startView: OnboardingTitleView
    private var endView: OnboardingTitleView
    
    public init(state: Binding<SBBOnboardingState>, currentCardIndex: Binding<Int>, startView: SBBOnboardingTitleView, endView: SBBOnboardingTitleView) {
        let viewModel = OnboardingViewModel(state: state, currentCardIndex: currentCardIndex, cardViews: [SBBOnboardingCardView]())
        self.viewModel = viewModel
        self.startView = OnboardingTitleView(viewModel: viewModel, sbbOnboardingTitleView: startView)
        self.endView = OnboardingTitleView(viewModel: viewModel, sbbOnboardingTitleView: endView)
    }
    
    public init(state: Binding<SBBOnboardingState>, currentCardIndex: Binding<Int>, startView: SBBOnboardingTitleView, endView: SBBOnboardingTitleView, @ArrayBuilder<SBBOnboardingCardView> content: () -> [SBBOnboardingCardView]) {
        let viewModel = OnboardingViewModel(state: state, currentCardIndex: currentCardIndex, cardViews: content())
        self.viewModel = viewModel
        self.startView = OnboardingTitleView(viewModel: viewModel, sbbOnboardingTitleView: startView)
        self.endView = OnboardingTitleView(viewModel: viewModel, sbbOnboardingTitleView: endView)
    }
        
    public var body: some View {
        Group {
            if viewModel.state == .startView {
                startView
            } else if viewModel.state == .endView {
                endView
            } else if viewModel.state == .cardsView {
                OnboardingCardsView(viewModel: viewModel)
            }
        }
            .navigationBarTitle("TODO delete string")   // Navigation Bar Title needs to be set for ignoring Safe Area Edges
            .navigationBarHidden(true)
    }
}

struct SBBOnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SBBOnboardingView(state: .constant(.startView), currentCardIndex: .constant(0), startView: FakeSBBOnboardingTitleViews.start, endView: FakeSBBOnboardingTitleViews.end)
                .previewDisplayName("StartView Light")
            SBBOnboardingView(state: .constant(.startView), currentCardIndex: .constant(0), startView: FakeSBBOnboardingTitleViews.start, endView: FakeSBBOnboardingTitleViews.end)
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
