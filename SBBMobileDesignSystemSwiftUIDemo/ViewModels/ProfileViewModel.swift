//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    var name: Text? = Text("Karin Burgmeister")
    var eMail: Text? = Text("karin.burgmeister@sbb.ch")
    
    @Published var isLoggedIn = true
    
    func login() {
        // perform login
        name = Text("Karin Burgmeister")
        eMail = Text("karin.burgmeister@sbb.ch")
        isLoggedIn = true
    }
    
    func logout() {
        // perform logout
        name = nil
        eMail = nil
        isLoggedIn = false
    }
}
