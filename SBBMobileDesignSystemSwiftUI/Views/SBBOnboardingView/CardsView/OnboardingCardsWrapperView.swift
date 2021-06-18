//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingCardsWrapperView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var dragOffset = CGSize.zero
        
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                Rectangle() // Fill the upper cornerRadius edges with red color, so that the View appears to only have cornerRadius at the bottom
                    .background(Color.sbbColor(.red).edgesIgnoringSafeArea(.top))
                    .frame(height: 16)
                if viewModel.currentCardView != nil {
                    GeometryReader { geometry in
                        ZStack {
                            ForEach((0..<self.viewModel.cardViews.count).reversed(), id: \.self) { index in
                                self.viewModel.cardViews[index]
                                    .offset(x: self.xOffsetForCard(at: index, cardWidth: geometry.size.width))
                                    .offset(y: self.yOffsetForCard(at: index))
                                    .scaleEffect(self.scaleFactorForCard(at: index), anchor: .top)
                                    .opacity(self.opacityForCard(at: index))
                                    .accessibilityElement(children: self.accessibilityHiddenForCard(at: index) ? .combine : .contain)   // elements of hidden cards need to be combined first (otherwise they are not hidden)
                                    .accessibility(hidden: self.accessibilityHiddenForCard(at: index))
                            }
                        }
                            .padding(.top, geometry.safeAreaInsets.top)
                            .padding(16)
                            .edgesIgnoringSafeArea(.top)
                            .clipped()
                            .background(Color.sbbColor(.red).cornerRadius(16).edgesIgnoringSafeArea([.top, .horizontal]))
                    }
                }
            }
            VStack(spacing: 16) {
                HStack {
                    Button(action: {
                        self.showPreviousCard()
                    }) {
                        Image(sbbName: "chevron-small-left", size: .small)
                            .resizable()
                            .accessibility(label: Text("back".localized))
                    }
                        .buttonStyle(SBBIconButtonStyle(size: .small))
                        .accessibility(identifier: "onboardingPreviousCardButton")
                    Spacer()
                    SBBPaginationView(currentPageIndex: $viewModel.currentCardIndex, numberOfPages: viewModel.cardViews.count)
                        .accessibility(hidden: true)
                    Spacer()
                    Button(action: {
                        self.showNextCard()
                    }) {
                        Image(sbbName: "chevron-small-right", size: .small)
                            .resizable()
                            .accessibility(label: Text("forward".localized))
                    }
                        .buttonStyle(SBBIconButtonStyle(size: .small))
                        .accessibility(identifier: "onboardingNextCardButton")
                }
                Button(action: {
                    self.viewModel.state = .hidden
                }) {
                    Text("abort tour".localized)
                }
                    .buttonStyle(SBBTertiaryButtonStyle(size: .small))
                    .accessibility(identifier: "onboardingAbortTourButton")
            }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
        }
            .foregroundColor(.sbbColor(.textBlack))
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.all))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.dragOffset = gesture.translation
                    }

                    .onEnded { _ in
                        if abs(self.dragOffset.width) > UIScreen.main.bounds.size.width / 4 {
                            if self.dragOffset.width > 0 {  // swipe right
                                self.showPreviousCard()
                            } else {    // swipe left
                                self.showNextCard()
                            }
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
            withAnimation {
                viewModel.currentCardIndex -= 1
                self.dragOffset = .zero
            }
        }
        UIAccessibility.post(notification: .screenChanged, argument: nil)   // reset voiceover focus (to the current card)
    }
    
    private func showNextCard() {
        if viewModel.currentCardIndex == viewModel.cardViews.count - 1 {
            viewModel.state = .endView
        } else {
            viewModel.currentCardView?.actionOnCardDisappear?()
            withAnimation {
                viewModel.currentCardIndex += 1
                self.dragOffset = .zero
            }
        }
        UIAccessibility.post(notification: .screenChanged, argument: nil)   // reset voiceover focus (to the current card)
    }
    
    private func xOffsetForCard(at index: Int, cardWidth: CGFloat) -> CGFloat {
        let dragOffset = self.showDragOffsetForCard(at: index) ? self.dragOffset.width : 0
        
        if index < self.viewModel.currentCardIndex {
            return CGFloat(index - self.viewModel.currentCardIndex) * cardWidth + dragOffset
        }
        
        return 0 + dragOffset
    }
    
    private func yOffsetForCard(at index: Int) -> CGFloat {
        if index > self.viewModel.currentCardIndex {
            return -CGFloat(index - self.viewModel.currentCardIndex) * 12
        }
        
        return 0
    }
    
    private func scaleFactorForCard(at index: Int) -> CGFloat {
        if index > self.viewModel.currentCardIndex {
            return 1 - (CGFloat(index - self.viewModel.currentCardIndex) * 0.1)
        }
        
        return 1
    }
    
    private func opacityForCard(at index: Int) -> Double {
        if index > self.viewModel.currentCardIndex {
            return 1 - (Double(index - self.viewModel.currentCardIndex) * 0.2)
        }
        
        return 1
    }
    
    private func showDragOffsetForCard(at index: Int) -> Bool {
        if dragOffset.width < 0 {    // dragging to the left
            return index <= self.viewModel.currentCardIndex
        } else if dragOffset.width > 0 {    // dragging to the right
            return index < self.viewModel.currentCardIndex
        }
        return false
    }
    
    private func accessibilityHiddenForCard(at index: Int) -> Bool {
        return !(index == self.viewModel.currentCardIndex)
    }
}

struct OnboardingCardsWrapperView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            OnboardingCardsWrapperView(viewModel: FakeOnboardingViewModels.startView)
                .previewDisplayName("Light")
            OnboardingCardsWrapperView(viewModel: FakeOnboardingViewModels.startView)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
