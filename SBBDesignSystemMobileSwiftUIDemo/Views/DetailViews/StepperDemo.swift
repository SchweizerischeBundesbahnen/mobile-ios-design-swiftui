//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct StepperDemo: View {
    
    @ObservedObject var viewModel: ProcessFlowViewModel
    @State var withLabel = false
    @Binding var colorScheme: ColorScheme
    
    private var labels = ["Worker", "Treasure", "Heart", "Apple", "Weather", "Bike"]
    
    init(viewModel: ProcessFlowViewModel, colorScheme: Binding<ColorScheme>) {
        self.viewModel = viewModel
        self._colorScheme = colorScheme
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBStepper(currentStepIndex: viewModel.currentStepIndex, numberOfSteps: viewModel.numberOfSteps, images: Array(viewModel.images[0..<viewModel.numberOfSteps]), labels: withLabel ? labels : nil)
                SBBFormGroup(title: "Customize Content") {
                    HStack {
                        Text("Current Step: \(viewModel.currentStepIndex)")
                            .sbbFont(.medium_light)
                        Spacer()
                        Button(action: {
                            viewModel.currentStepIndex -= 1
                        }) {
                            Image(sbbIcon: .chevron_small_right_small)
                                .resizable()
                                .rotationEffect(Angle(degrees: 180))
                        }
                        .buttonStyle(SBBIconButtonStyle(size: .small))
                        .disabled(viewModel.currentStepIndex == 0)
                        Button(action: {
                            viewModel.currentStepIndex += 1
                        }) {
                            Image(sbbIcon: .chevron_small_right_small)
                                .resizable()
                        }
                        .buttonStyle(SBBIconButtonStyle(size: .small))
                        .disabled(viewModel.currentStepIndex == viewModel.numberOfSteps - 1)
                    }
                    .padding(16)
                    
                    SBBDivider()
                    Stepper("Number of Steps: \(viewModel.numberOfSteps)", value: $viewModel.numberOfSteps, in: 3...6)
                        .sbbFont(.medium_light)
                        .padding(16)
                    SBBDivider()
                    Toggle(isOn: $withLabel, label: { Text("Use labels ") })
                        .toggleStyle(SBBSwitchStyle())
                        .padding(16)
                }
            }
            .sbbScreenPadding()
        }
        .navigationBarTitle("ProcessFlow")
        .sbbStyle()
        .sbbBackButtonStyle()
        .colorScheme(colorScheme)
        
    }
}

struct StepperDemo_Previews: PreviewProvider {
    
    static let viewModel = ProcessFlowViewModel()
    
    static var previews: some View {
        Group {
            StepperDemo(viewModel: ProcessFlowViewModel(), colorScheme: .constant(.light))
            StepperDemo(viewModel: ProcessFlowViewModel(), colorScheme: .constant(.dark))
        }
    }
}
