//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import XCTest
import SnapshotTesting

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        return vc
    }
}

extension XCTestCase {
    
    // set to true to enable reference screenshot recording instead of snapshot comparison (make sure to set your simulator in .light appearance!)
    var recordNewReferenceSnapshots: Bool {
        return false
    }
    
    var traitLightMode: UITraitCollection {
        return UITraitCollection(userInterfaceStyle: .light)
    }
    
    var precision: Float {
        1
    }
    
    var perceptualPrecision: Float {
        0.98
    }
    
    var imagePortrait: Snapshotting<UIViewController, UIImage> {
        return .image(perceptualPrecision: perceptualPrecision, traits: traitLightMode)
    }
    
    var imageLandscape: Snapshotting<UIViewController, UIImage> {
        return .image(on: .iPhone13(.landscape), perceptualPrecision: perceptualPrecision, traits: traitLightMode)
    }
}

extension View {
    
    // records a .png image file of a View and saves it to the Documentation/Resources folder inside the SBBDesignSystemMobileSwiftUI target to be then used in markdown code documentation
    func recordDocumentationSnapshot(name: String, colorScheme: ColorScheme) {
        let containingView = Group {
            self
                .padding()
        }
            .border(Color.sbbColor(.metal))
            .background(Color.sbbColor(.background))
            .edgesIgnoringSafeArea(.all)

        let controller = containingView.colorScheme(colorScheme).toVC()
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
            let fileURL = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("SBBDesignSystemMobileSwiftUI").appendingPathComponent("Documentation.docc").appendingPathComponent("Resources").appendingPathComponent("\(filename).png")
            try? data.write(to: fileURL)
        }
    }
}
