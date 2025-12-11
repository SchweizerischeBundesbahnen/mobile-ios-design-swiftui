//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Applies SBB styling to a View. It applies a specific background color, adds a SBBNavigationBarSBBIcon as trailing Navigation Bar Item and sets a default Font.
     
     ## Overview
     You typically apply the sbbStyle() View modifier to the upmost View in the hierarchy:
     ```swift
     var body: some View {
         YourView()
             .sbbStyle()
     }
     ```
     ![SBBStyle](SBBStyle)
     
     - Parameters:
        - showSBBIcon: If set, a SBB Icon is shown on the trailing edge of the NavigationBar. Only set this value to false if you want to use a custom icon.
     */
    func sbbStyle(showSBBIcon: Bool = true) -> some View {
        if #available(iOS 26.0, *) {
            return self
                .background(Color.sbbColor(.background).edgesIgnoringSafeArea([.bottom, .horizontal]))
                .foregroundColor(.sbbColor(.textBlack))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        showSBBIcon ? SBBNavigationBarSBBIcon() : nil
                    }
                    .sharedBackgroundVisibility(.hidden)
                    }
                .sbbFont(.medium_light)
        } else {
            return self
                .background(Color.sbbColor(.background).edgesIgnoringSafeArea([.bottom, .horizontal]))
                .foregroundColor(.sbbColor(.textBlack))
                .navigationBarItems(trailing: showSBBIcon ? SBBNavigationBarSBBIcon() : nil)
                .sbbFont(.medium_light)
        }
    }
    
    
    /**
     Applies SBB styling to a the navigation bar back button. For iOS 26 and higher, it hides the default back button and adds a custom one, so that liquid glass is not used. For older version, it does nothing.
     
     ## Overview
     You typically apply the sbbBackButtonStyle() View modifier to the upmost View in the hierarchy, if it has a back button:
     ```swift
     var body: some View {
         YourView()
             .sbbBackButtonStyle()
     }
     ```
     */
    @ViewBuilder
    func sbbBackButtonStyle() -> some View {
        if #available(iOS 26.0, *) {
            self
                .modifier(NavigationBarBackButton())
        } else {
            self
        }
    }
}

@available(iOS 26.0, *)
struct NavigationBarBackButton: ViewModifier {
    @Environment(\.dismiss) private var dismiss
        
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(sbbIcon: .chevron_left_small)
                            .foregroundStyle(Color.sbbColor(.textWhite))
                    }
                }
                    .sharedBackgroundVisibility(.hidden)
                }
            .onAppear {
                content.enableSwipeBack()
            }
    }
}

extension View {
    func enableSwipeBack() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let navigationController = window.rootViewController?.navigationController ??
                findNavigationController(in: window.rootViewController) else {
            return
        }
        
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func findNavigationController(in viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for child in viewController.children {
            if let found = findNavigationController(in: child) {
                return found
            }
        }
        
        return nil
    }
}
