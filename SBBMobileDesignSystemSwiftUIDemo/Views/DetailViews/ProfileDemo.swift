//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

public struct ProfileDemo: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var colorScheme: ColorScheme
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBProfile(userName: viewModel.name, userEmail: viewModel.eMail, isLoggedIn: $viewModel.isLoggedIn, loginAction:  {viewModel.login()}, logoutAction: {viewModel.logout()})
            }
            .padding(16)
        }
            .navigationBarTitle("Profile")
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
            .colorScheme(colorScheme)
    }
}

struct ProfileDemo_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ProfileDemo(viewModel: ProfileViewModel(), colorScheme: .constant(.light))
                .previewDisplayName("Light")
            ProfileDemo(viewModel: ProfileViewModel(), colorScheme: .constant(.dark))
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
            ProfileDemo(viewModel: ProfileViewModel(), colorScheme: .constant(.light))
                .previewDisplayName("Accessibility XXXL")
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
            .previewLayout(.sizeThatFits)
    }
}
