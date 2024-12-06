//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

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
                
                Button(action: {
                    let uuid = UUID()
                    counter += 1
                    toastService.showToast(SBBToast(label: Text("Hello Toast \(counter)\nThis Toast has multiple lines, in fact it might be longer than 2 IC2000 compositions linked together."), id: uuid, actionLabel: Text("Remove it"), onClickAction: {
                        toastService.removeToast(where: { $0.id == uuid })
                    }))
                }) {
                    Text("Show Multiline Toast with Action")
                }
                    .buttonStyle(SBBSecondaryButtonStyle())
                Button(action: {
                    let uuid = UUID()
                    counter += 1
                    toastService.showToast(SBBToast(label: Text("Hello Toast \(counter)"), id: uuid, actionLabel: Text("Remove it"), onClickAction: {
                        toastService.removeToast(where: { $0.id == uuid })
                    }))
                }) {
                    Text("Show Toast with Action")
                }
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .sbbScreenPadding()
        }
            .frame(maxWidth: .infinity)
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
