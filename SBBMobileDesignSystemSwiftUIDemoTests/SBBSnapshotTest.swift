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

extension View {
    
    // records a .png image file of a View and saves it to the Documentation/Resources folder inside the SBBMobileDesignSystemSwiftUI target to be then used in markdown code documentation
    func recordDocumentationSnapshot(name: String, colorScheme: ColorScheme) {
        let controller = self.colorScheme(colorScheme).toVC()
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        let image = renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
        if let data = image.pngData() {
            let filename = (colorScheme == .light) ? name : "\(name)~dark"
            let fileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("SBBMobileDesignSystemSwiftUI").appendingPathComponent("Documentation.docc").appendingPathComponent("Resources").appendingPathComponent("\(filename).png")
            try? data.write(to: fileURL)
        }
    }
}
