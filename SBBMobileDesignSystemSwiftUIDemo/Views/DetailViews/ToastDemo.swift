//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ToastDemo: View {
    
    @EnvironmentObject var toastService: SBBToastService
    @Binding var colorScheme: ColorScheme
    @State var counter = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                Button(action: {
                    counter += 1
                    toastService.showToast(SBBToast(label: Text("Hello Toast \(counter)\nThis Toast has multiple lines, in fact it might be longer than 2 IC2000 compositions linked together.")))
                }) {
                    Text("Show Multiline Toast")
                }
                    .buttonStyle(SBBSecondaryButtonStyle())
                Button(action: {
                    counter += 1
                    toastService.showToast(SBBToast(label: Text("Hello Toast \(counter)")))
                }) {
                    Text("Show Toast")
                }
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .padding(16)
        }
            .navigationBarTitle("Toast")
            .sbbStyle()
            .sbbToastContainer()
            .colorScheme(colorScheme)
            
    }
}

struct ToastDemo_Previews: PreviewProvider {
    
    static let toastViewModel = SBBToastService()
    
    static var previews: some View {
        Group {
            ToastDemo(colorScheme: .constant(.light))
            ToastDemo(colorScheme: .constant(.dark))
        }
            .environmentObject(toastViewModel)
    }
}
