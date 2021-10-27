//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        return vc
    }
}
