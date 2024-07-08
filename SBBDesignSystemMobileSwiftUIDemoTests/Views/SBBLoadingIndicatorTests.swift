//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBLoadingIndicatorTests: XCTestCase {
    
    // WORKAROUND:  no 3D rotation applied on standard snapshots but Documentation snapshots renders indicator correctly (e.g. image) -> renders image and compare that
    private func renderSBBLoadingIndicator(view: any View, colorScheme: ColorScheme) -> UIViewController {
        let controller = view.colorScheme(colorScheme).toVC()
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        let image = renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
        return Image(uiImage: image).toVC()
    }
    
    func testLoadingIndicatorNormalPrimary() {
        let view = SBBLoadingIndicator(size: .normal, style: .primary)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBLoadingIndicator", colorScheme: colorScheme)
            assertSnapshot(matching: renderSBBLoadingIndicator(view: view, colorScheme: colorScheme), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testLoadingIndicatorNormalGrey() {
        let view = SBBLoadingIndicator(size: .normal, style: .grey)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: renderSBBLoadingIndicator(view: view, colorScheme: colorScheme), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testLoadingIndicatorNormalWhite() {
        let view = SBBLoadingIndicator(size: .normal, style: .primaryBackground)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: renderSBBLoadingIndicator(view: view, colorScheme: colorScheme), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testLoadingIndicatorSmallPrimary() {
        let view = SBBLoadingIndicator(size: .small, style: .primary)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: renderSBBLoadingIndicator(view: view, colorScheme: colorScheme), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testLoadingIndicatorTineyPrimary() {
        let view = SBBLoadingIndicator(size: .tiny, style: .primary)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: renderSBBLoadingIndicator(view: view, colorScheme: colorScheme), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
