//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ProcessFlowDemo: View {
    
    @ObservedObject var viewModel: ProcessFlowViewModel
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBProcessFlow(currentStepIndex: viewModel.currentStepIndex, images: Array(viewModel.images[0..<viewModel.numberOfSteps]))
                SBBFormGroup(title: "Customize Content") {
                    HStack {
                        Text("Current Step: \(viewModel.currentStepIndex)")
                            .sbbFont(.body)
                        Spacer()
                        Button(action: {
                            viewModel.currentStepIndex -= 1
                        }) {
                            Image(sbbName: "chevron-small-right", size: .small)
                                .resizable()
                                .rotationEffect(Angle(degrees: 180))
                        }
                            .buttonStyle(SBBIconButtonStyle(size: .small))
                            .disabled(viewModel.currentStepIndex == 0)
                        Button(action: {
                            viewModel.currentStepIndex += 1
                        }) {
                            Image(sbbName: "chevron-small-right", size: .small)
                                .resizable()
                        }
                            .buttonStyle(SBBIconButtonStyle(size: .small))
                            .disabled(viewModel.currentStepIndex == viewModel.numberOfSteps - 1)
                    }
                        .padding(16)
                    SBBDivider()
                    Stepper("Number of Steps: \(viewModel.numberOfSteps)", value: $viewModel.numberOfSteps, in: 2...6)
                        .sbbFont(.body)
                    .padding(16)
                }
            }
                .sbbScreenPadding()
        }
            .navigationBarTitle("ProcessFlow")
            .sbbStyle()
            .colorScheme(colorScheme)
            
    }
}

struct ProcessFlowDemo_Previews: PreviewProvider {
    
    static let viewModel = ProcessFlowViewModel()
    
    static var previews: some View {
        Group {
            ProcessFlowDemo(viewModel: viewModel, colorScheme: .constant(.light))
            ProcessFlowDemo(viewModel: viewModel, colorScheme: .constant(.dark))
        }
    }
}
