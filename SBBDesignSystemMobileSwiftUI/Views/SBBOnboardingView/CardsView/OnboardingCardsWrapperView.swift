//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct OnboardingCardsWrapperView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var dragOffset = CGSize.zero
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    func cardsView(safeAreaInsetsLeading: CGFloat? = nil) -> some View {
        return Group {
            if viewModel.currentCardView != nil {
                GeometryReader { geometry in
                    ZStack {
                        ForEach((0..<self.viewModel.cardViews.count).reversed(), id: \.self) { index in
                            self.viewModel.cardViews[index]
                                .offset(x: self.xOffsetForCard(at: index, cardWidth: geometry.size.width, safeAreaInsetsLeading: safeAreaInsetsLeading != nil ? safeAreaInsetsLeading! : geometry.safeAreaInsets.leading))
                                .offset(y: self.yOffsetForCard(at: index))
                                .scaleEffect(self.scaleFactorForCard(at: index), anchor: .top)
                                .opacity(self.opacityForCard(at: index))
                                .accessibilityElement(children: self.accessibilityHiddenForCard(at: index) ? .combine : .contain)   // elements of hidden cards need to be combined first (otherwise they are not hidden)
                                .accessibility(hidden: self.accessibilityHiddenForCard(at: index))
                        }
                    }
                        .edgesIgnoringSafeArea(.top)
                        .padding([.horizontal, .bottom], 8)
                        .padding(.top, 16)
                        .background(Color.sbbColor(.primary).edgesIgnoringSafeArea([.top, .horizontal]))
                }
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            self.showPreviousCard()
        }) {
            Image(sbbIcon: .chevron_small_left_small)
                .resizable()
                .accessibility(label: Text("back".localized))
        }
    }
    
    private var nextButton: some View {
        Button(action: {
            self.showNextCard()
        }) {
            Image(sbbIcon: .chevron_small_right_small)
                .resizable()
                .accessibility(label: Text("forward".localized))
        }
    }
    
    private var portraitView: some View {
        VStack(spacing: 0) {
            cardsView()
                .accessibilitySortPriority(2)
            VStack(spacing: 16) {
                HStack {
                    backButton
                        .buttonStyle(SBBIconButtonStyle(size: .small))
                        .accessibility(identifier: "onboardingPreviousCardButton")
                        .accessibilitySortPriority(3)
                    Spacer()
                    SBBPaginationView(currentPageIndex: $viewModel.currentCardIndex, numberOfPages: viewModel.cardViews.count)
                        .accessibility(hidden: true)
                    Spacer()
                    nextButton
                        .buttonStyle(SBBIconButtonStyle(size: .small))
                        .accessibility(identifier: "onboardingNextCardButton")
                        .accessibilitySortPriority(1)
                }
                Button(action: {
                    self.viewModel.state = .hidden
                }) {
                    Text("abort tour".localized)
                }
                    .buttonStyle(SBBTertiaryButtonStyle(size: .small))
                    .accessibility(identifier: "onboardingAbortTourButton")
                    .accessibilitySortPriority(0)
            }
                .padding(.horizontal, 8)
                .padding(.vertical, 24)
        }
            .foregroundColor(.sbbColor(.textBlack))
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.all))
    }
    
    private var landscapeView: some View {
        GeometryReader { geometry in
            HStack(spacing: 8) {
                VStack {
                    Spacer()
                    backButton
                        .buttonStyle(SBBIconButtonStyle(size: .large, style: .negative))
                        .accessibility(identifier: "onboardingPreviousCardButton")
                        .accessibilitySortPriority(3)
                    Spacer()
                }
                cardsView(safeAreaInsetsLeading: 44 + 10 + 8 + geometry.safeAreaInsets.leading)
                    .accessibilitySortPriority(2)
                ZStack {
                    VStack {
                        Button(action: {
                            self.viewModel.state = .hidden
                        }) {
                            Image(sbbIcon: .cross_small)
                                .resizable()
                                .accessibility(label: Text("abort tour".localized))
                        }
                            .buttonStyle(SBBIconButtonStyle(size: .large, style: .negative))
                            .accessibility(identifier: "onboardingAbortTourButton")
                            .padding(.top, 16)
                            .accessibilitySortPriority(0)
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        nextButton
                            .buttonStyle(SBBIconButtonStyle(size: .large, style: .negative))
                            .accessibility(identifier: "onboardingNextCardButton")
                            .accessibilitySortPriority(1)
                        Spacer()
                    }
                }
            }
                .sbbScreenPadding(.horizontal)
                .background(Color.sbbColor(.primary).edgesIgnoringSafeArea(.all))
        }
    }
        
    var body: some View {
        Group {
            if self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular {
                portraitView
            } else {
                landscapeView
            }
        }
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
    
    private func xOffsetForCard(at index: Int, cardWidth: CGFloat, safeAreaInsetsLeading: CGFloat) -> CGFloat {
        let dragOffset = self.showDragOffsetForCard(at: index) ? self.dragOffset.width : 0
        
        if index < self.viewModel.currentCardIndex {
            
            let offset = CGFloat(index - self.viewModel.currentCardIndex) * cardWidth + dragOffset - safeAreaInsetsLeading
            return offset
        }
        return 0 + dragOffset
    }
    
    private func yOffsetForCard(at index: Int) -> CGFloat {
        if index > self.viewModel.currentCardIndex {
            return -CGFloat(index - self.viewModel.currentCardIndex) * 8
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
            return 1 - (Double(index - self.viewModel.currentCardIndex) * (1/3))
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
