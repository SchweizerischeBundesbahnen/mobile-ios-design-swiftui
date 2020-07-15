//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBOnboardingView: View {
    
    @ObservedObject private var viewModel: SBBOnboardingViewModel
    
    public init(viewModel: SBBOnboardingViewModel) {
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
            SBBOnboardingView(viewModel: FakeSBBOnboardingViewModels.startView)
                .previewDisplayName("StartView Light")
            SBBOnboardingView(viewModel: FakeSBBOnboardingViewModels.startView)
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
