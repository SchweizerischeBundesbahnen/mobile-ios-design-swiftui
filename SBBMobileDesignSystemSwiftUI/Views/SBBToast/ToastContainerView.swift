//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

struct ToastContainerView: View {
    
    @EnvironmentObject private var toastService: SBBToastService
    @Environment(\.colorScheme) private var colorScheme
        
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            ForEach(toastService.toasts) { toast in
                ToastView(viewModel: toast)
                    .onAppear {
                        toast.isPresented = true

                        DispatchQueue.main.asyncAfter(deadline: .now() + toast.easeInOutAnimationDuration + toast.presentedDuration, execute: DispatchWorkItem {
                            toast.isPresented = false
                        })
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + toast.easeInOutAnimationDuration + toast.presentedDuration + toast.easeInOutAnimationDuration, execute: DispatchWorkItem {
                            toastService.removeToast(toast)
                        })
                    }
            }
        }
            .padding(8)
    }
}

struct ToastContainerView_Previews: PreviewProvider {
    
    static var sbbToastViewModel = SBBToastService(toasts: [SBBToast(label: Text("Hello Toast")), SBBToast(label: Text("Hello Toast\nThis Toast has multiple lines, in fact it might be longer than 2 IC2000 compositions linked together."))])
    
    static var previews: some View {
        Group {
            ToastContainerView()
                .previewDisplayName("light")
            ToastContainerView()
                .previewDisplayName("dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
            .environmentObject(sbbToastViewModel)
    }
}
