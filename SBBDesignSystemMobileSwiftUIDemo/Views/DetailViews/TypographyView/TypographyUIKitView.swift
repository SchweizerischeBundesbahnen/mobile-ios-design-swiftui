//
//  Copyright © 2020 SBB. All rights reserved.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct TypographyUIKitView: UIViewControllerRepresentable {
    
    let isDarkMode: Bool
    
    func makeUIViewController(context: Context) -> TypographyViewController {
        let sb = UIStoryboard(name: "Typography", bundle: .main)
        let ctrl = sb.instantiateViewController(identifier: "TypographyViewController")
        
        if isDarkMode {
            ctrl.view.backgroundColor = .black
        }
        
        return ctrl as! TypographyViewController
    }
    
    func updateUIViewController(_ uiViewController: TypographyViewController, context: Context) {
    }
    
}

struct TypographyUIKitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TypographyUIKitView(isDarkMode: false)
                .previewDisplayName("Light")
            TypographyUIKitView(isDarkMode: true)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
