//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingCardsView: View {
    
    @ObservedObject var viewModel: SBBOnboardingViewModel
    @State private var dragOffset = CGSize.zero
        
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.currentCardView != nil {
                GeometryReader { geometry in
                    ZStack {
                        self.viewModel.currentCardView
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
                    SBBPaginationView(currentPageIndex: $viewModel.currentCardIndex, numberOfPages: viewModel.cardViews.count)
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
                    self.viewModel.state = .hidden
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
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.dragOffset = gesture.translation
                        print(self.dragOffset.width)
                    }

                    .onEnded { _ in
                        if abs(self.dragOffset.width) > 100 {   // TODO - define meaningful threshold
                            if self.dragOffset.width > 0 {  // swipe right
                                self.showPreviousCard()
                            } else {    // swipe left
                                self.showNextCard()
                            }
                            self.dragOffset = .zero
                        } else {
                            self.dragOffset = .zero
                        }
                    }
            )
    }
    
    private func showPreviousCard() {
        if viewModel.currentCardIndex == 0 {
            viewModel.state = .startView
        } else {
            viewModel.currentCardIndex -= 1
        }
    }
    
    private func showNextCard() {
        if viewModel.currentCardIndex == viewModel.cardViews.count - 1 {
            viewModel.state = .endView
        } else {
            viewModel.currentCardIndex += 1
        }
    }
}

struct OnboardingCardsView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            OnboardingCardsView(viewModel: FakeSBBOnboardingViewModels.startView)
                .previewDisplayName("Light")
            OnboardingCardsView(viewModel: FakeSBBOnboardingViewModels.startView)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
