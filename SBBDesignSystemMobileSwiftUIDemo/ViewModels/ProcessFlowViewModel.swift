//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

class ProcessFlowViewModel: ObservableObject {
    @Published var currentStepIndex = 1
    @Published var numberOfSteps = 3 {
        didSet {
            if currentStepIndex >= numberOfSteps {
                currentStepIndex = numberOfSteps - 1
            }
        }
    }
        
    var images: [Image] = [Image(sbbName: "face-worker", size: .small), Image(sbbName: "piggy-bank", size: .small), Image(sbbName: "heart", size: .small), Image(sbbName: "bottle-apple", size: .small), Image(sbbName: "cloud-little-snow-moon", size: .small), Image(sbbName: "bicycle", size: .small)]
}

