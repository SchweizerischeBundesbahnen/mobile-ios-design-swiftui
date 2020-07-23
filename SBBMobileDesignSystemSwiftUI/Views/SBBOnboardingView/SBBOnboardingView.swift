//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBOnboardingView: View {
    
    @ObservedObject private var viewModel: OnboardingViewModel
    
    public init(state: Binding<SBBOnboardingState>, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel) {
        self.viewModel = OnboardingViewModel(state: state, startViewModel: startViewModel, endViewModel: endViewModel, cardViews: [SBBOnboardingCardView]())
    }
    
    public init(state: Binding<SBBOnboardingState>, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel, @ArrayBuilder<SBBOnboardingCardView> content: () -> [SBBOnboardingCardView]) {
        self.viewModel = OnboardingViewModel(state: state, startViewModel: startViewModel, endViewModel: endViewModel, cardViews: content())
    }
    
    // non-public initializer for SwiftUI Previews with Fake Model
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
        
    public var body: some View {
        Group {
            if viewModel.state == .startView || viewModel.state == .endView {
                OnboardingTitleView(viewModel: viewModel)
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
            SBBOnboardingView(viewModel: FakeOnboardingViewModels.startView)
                .previewDisplayName("StartView Light")
            SBBOnboardingView(viewModel: FakeOnboardingViewModels.startView)
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
