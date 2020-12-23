//
//  SBBUITest.swift
//  SBBMobileDesignSystemSwiftUIDemoTests
//
//  Created by Terence Alberti on 23.12.20.
//  Copyright © 2020 SBB. All rights reserved.
//

import SwiftUI

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        return vc
    }
}
