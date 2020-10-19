//
//  Copyright © 2020 SBB. All rights reserved.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TypographyUIKitView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ME01TypographyViewController {
        let sb = UIStoryboard(name: "Typography", bundle: .main)
        let ctrl = sb.instantiateViewController(identifier: "ME01TypographyViewController")
        
        return ctrl as! ME01TypographyViewController
    }
    
    func updateUIViewController(_ uiViewController: ME01TypographyViewController, context: Context) {
        
    }
    
}

struct TypographyUIKitView_Previews: PreviewProvider {
    static var previews: some View {
        TypographyUIKitView()
    }
}
