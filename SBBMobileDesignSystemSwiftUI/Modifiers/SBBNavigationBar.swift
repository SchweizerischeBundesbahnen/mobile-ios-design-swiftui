//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBNavigationBar: ViewModifier {
    
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .background(NavigationInlineBackgroundNC())
            .navigationBarItems(trailing: Image("sbb-logo-small", bundle: Helper.bundle))
    }
}

// inspired by https://stackoverflow.com/questions/56505528/swiftui-update-navigation-bar-title-color
struct NavigationInlineBackgroundNC: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationInlineBackgroundNC>) -> UINavigationController {
        return UINavigationController()
    }
    
    func updateUIViewController(_ navController: UINavigationController, context: UIViewControllerRepresentableContext<NavigationInlineBackgroundNC>) {
        if let nb = navController.navigationController?.navigationBar {
            // modify NavigationView with displayMode .inline
            // if displayMode is .large, the navigationBar is not inside navController.navigationController.navigationBar. Use setupAppearance in this case.
            nb.barTintColor = UIColor(cgColor: CGColor(srgbRed: 235, green: 0, blue: 0, alpha: 1))
            nb.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.white/*,
                NSAttributedString.Key.font : SBBFonts().sbbWeb_Light(size: 22)*/]    // todo: Fonts
        }
    }
}
