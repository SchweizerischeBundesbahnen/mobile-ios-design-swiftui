//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import XCTest

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        return vc
    }
}

extension XCTestCase {
    
    // set to true to enable reference screenshot recording instead of snapshot comparison
    var recordNewReferenceSnapshots: Bool {
        return false
    }
}
