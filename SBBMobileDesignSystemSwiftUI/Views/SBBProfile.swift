//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public struct SBBProfile: View {
    
    @Binding private var isLoggedIn: Bool
    private let userName: Text?
    private let userEmail: Text?
    private let loginAction: (() -> ())
    private let logoutAction: (() -> ())
    
    public init(userName: Text? = nil, userEmail: Text? = nil, isLoggedIn: Binding<Bool>, loginAction: @escaping (() -> ()), logoutAction: @escaping (() -> ())) {
        self.userName = userName
        self.userEmail = userEmail
        self._isLoggedIn = isLoggedIn
        self.loginAction = loginAction
        self.logoutAction = logoutAction
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                if isLoggedIn {
                    Text("You're logged in as:".localized)
                    VStack(alignment: .leading, spacing: 0) {
                        userName
                            .sbbFont(.body)
                            .foregroundColor(.sbbColor(.textBlack))
                        userEmail
                    }
                } else {
                    Text("You're not logged in.".localized)
                }
            }
                .sbbFont(.legend)
                .foregroundColor(.sbbColor(.textMetal))
            Spacer()
            Button(action: isLoggedIn ? logoutAction : loginAction) {
                Text(isLoggedIn ? "Logout".localized : "Login".localized)
            }
            .buttonStyle(SBBTertiaryButtonStyle(size: .small))
        }
            .padding(16)
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16)
            .accessibilityElement(children: .combine)
            .accessibility(hint: Text(isLoggedIn ? "Logout".localized : "Login".localized))
    }
}

struct SBBProfile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBProfile(userName: Text("Karin Burgmeister"), isLoggedIn: .constant(true), loginAction: {}, logoutAction: {})
                .previewDisplayName("Logged in, light")
            SBBProfile(userName: Text("Karin Burgmeister"), isLoggedIn: .constant(true), loginAction: {}, logoutAction: {})
                .previewDisplayName("Logged in, dark")
                .environment(\.colorScheme, .dark)
            SBBProfile(userName: Text("Karin Burgmeister"), userEmail: Text("karin.burgmeister@sbb.ch"), isLoggedIn: .constant(true), loginAction: {}, logoutAction: {})
                .previewDisplayName("Logged in with eMail, light")
            SBBProfile(isLoggedIn: .constant(false), loginAction: {}, logoutAction: {})
                .previewDisplayName("Logged out, light")
        }
            .previewLayout(.sizeThatFits)
    }
}
