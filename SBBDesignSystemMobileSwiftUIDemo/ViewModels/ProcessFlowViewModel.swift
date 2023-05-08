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
        
    var images: [Image] = [Image(sbbIcon: .face_worker_small), Image(sbbIcon: .piggy_bank_small), Image(sbbIcon: .heart_small), Image(sbbIcon: .bottle_apple_small), Image(sbbIcon: .cloud_little_snow_moon_small), Image(sbbIcon: .bicycle_small)]
}

