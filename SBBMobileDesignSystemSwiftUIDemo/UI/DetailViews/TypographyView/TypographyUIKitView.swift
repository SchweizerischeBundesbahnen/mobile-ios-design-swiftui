//
//  Copyright © 2020 SBB. All rights reserved.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TypographyUIKitView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> TypographyViewController {
        let sb = UIStoryboard(name: "Typography", bundle: .main)
        let ctrl = sb.instantiateViewController(identifier: "TypographyViewController")
        return ctrl as! TypographyViewController
    }
    
    func updateUIViewController(_ uiViewController: TypographyViewController, context: Context) {
    }
    
}

struct TypographyUIKitView_Previews: PreviewProvider {
    static var previews: some View {
        TypographyUIKitView()
    }
}
