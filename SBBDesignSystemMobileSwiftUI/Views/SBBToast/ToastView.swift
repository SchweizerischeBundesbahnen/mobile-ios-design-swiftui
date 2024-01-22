//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public struct ToastView: View {
    
    @ObservedObject private var viewModel: SBBToast
    @Environment(\.colorScheme) private var colorScheme
    
    public init(viewModel: SBBToast) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        viewModel.label
            .sbbFont(.small_light)
            .foregroundColor(Color.sbbColor(.white))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background((colorScheme == .light) ? Color.black.opacity(0.5): Color.white.opacity(0.3))
            .cornerRadius(19)
            .opacity(viewModel.isPresented ? 1 : 0)
            .animation(.easeInOut(duration: viewModel.easeInOutAnimationDuration))
    }
}

struct ToastView_Previews: PreviewProvider {
    
    static let viewModel = SBBToast(label: Text("Hello Toast"), isPresented: true)
    
    static var previews: some View {
        Group {
            ToastView(viewModel: viewModel)
                .previewDisplayName("light")
            ToastView(viewModel: viewModel)
                .previewDisplayName("dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
