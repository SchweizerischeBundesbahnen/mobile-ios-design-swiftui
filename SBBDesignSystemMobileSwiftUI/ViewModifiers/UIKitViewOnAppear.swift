//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Foundation
import SwiftUI

// Workaround for current SwiftUI .onAppear() and .onDisappear() issues, inspired by: https://developer.apple.com/forums/thread/655338?page=2

public extension View {
    func uiKitOnAppear(_ perform: @escaping () -> Void) -> some View {
        return self.background(UIKitAppear(action: perform))
    }
    
    func uiKitOnDisappear(_ perform: @escaping () -> Void) -> some View {
        return self.background(UIKitDisappear(action: perform))
    }
}

struct UIKitAppear: UIViewControllerRepresentable {
    let action: () -> Void
    
    func makeUIViewController(context: Context) -> UIAppearViewController {
       let vc = UIAppearViewController()
        vc.appearAction = action
        return vc
    }
    
    func updateUIViewController(_ controller: UIAppearViewController, context: Context) {
        controller.appearAction = action
    }
}

struct UIKitDisappear: UIViewControllerRepresentable {
    let action: () -> Void
    
    func makeUIViewController(context: Context) -> UIAppearViewController {
       let vc = UIAppearViewController()
        vc.disappearAction = action
        return vc
    }
    
    func updateUIViewController(_ controller: UIAppearViewController, context: Context) {
        controller.disappearAction = action
    }
}

class UIAppearViewController: UIViewController {
    var appearAction: () -> Void = {}
    var disappearAction: () -> Void = {}
    
    override func viewDidLoad() {
        view.addSubview(UILabel())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        appearAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disappearAction()
    }
}
