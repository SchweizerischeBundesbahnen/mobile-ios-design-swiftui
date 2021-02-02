//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

class DialogueViewModel: ObservableObject {
    
    @Published var showDialogue = false
    
    // SBBDialogue style
    @Published var fullscreen = true {
        didSet {
            if fullscreen {
                inline = false
                list = false
            }
        }
    }
    @Published var inline = false {
        didSet {
            if inline {
                fullscreen = false
                list = false
            }
        }
    }
    @Published var list = false {
        didSet {
            if list {
                fullscreen = false
                inline = false
            }
        }
    }
    
    // SBBDialogue Action type
    @Published var customActions = true {
        didSet {
            if customActions {
                retryAction = false
            }
        }
    }
    @Published var retryAction = false {
        didSet {
            if retryAction {
                customActions = false
            }
        }
    }
    
    // SBBDialogue Image type
    @Published var showImage = true
    @Published var happy = true {
        didSet {
            if happy {
                sad = false
            }
        }
    }
    @Published var sad = false {
        didSet {
            if sad {
                happy = false
            }
        }
    }
    
}
