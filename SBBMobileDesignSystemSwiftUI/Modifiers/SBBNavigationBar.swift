//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBNavigationBar: ViewModifier {
    
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .background(NavigationInlineBackgroundNC())
            .navigationBarItems(trailing: Image("sbb-logo-small", bundle: Helper.bundle).accessibility(hidden: true))
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
            
            nb.tintColor = .white
            nb.barTintColor = UIColor(cgColor: CGColor(srgbRed: 235, green: 0, blue: 0, alpha: 1))
            nb.shadowImage = UIImage()  // hide bottom line of NavigationBar
            //nb.isTranslucent = false  // current SwiftUI bug (resulting in app crash), see: https://stackoverflow.com/questions/58303421/swiftui-disable-translucence-in-navigationview
            //nb.setBackgroundImage(UIImage(color: UIColor(cgColor: CGColor(srgbRed: 235, green: 0, blue: 0, alpha: 1))), for: .default)    // fix for removing translucency (but then the List() or VStack() moves under the NavigationBar, see https://stackoverflow.com/questions/56505528/swiftui-update-navigation-bar-title-color
            nb.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "SBBWeb-Light", size: 22)!]
        }
    }
}
