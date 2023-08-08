//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct MessageDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    let title = Text("Title, single line if possible.")
    let text = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.")
    
    enum TopType {
        case info
        case error
        case custom
    }
    
    enum BottomType {
        case none
        case loading
        case retry
        case custom
    }
    
    @State var topType: TopType = .info
    @State var bottomType: BottomType = .none
    @State var error: Bool = false
    
    private var demoView: some View {
        Group {
            if topType == .custom {
                if bottomType == .custom {
                    SBBMessage(title: title, text: text, topImage: Image(sbbIcon: .binoculars_large), bottomImage: Image(sbbIcon: .arrows_circle_small), errorCode: error ? Text("Error: 404") : nil)
                } else if bottomType == .retry {
                    SBBMessage(title: title, text: text, topImage: Image(sbbIcon: .binoculars_large), errorCode: error ? Text("Error: 404") : nil, retry: {})
                } else {
                    SBBMessage(title: title, text: text, topImage: Image(sbbIcon: .binoculars_large), errorCode: error ? Text("Error: 404") : nil, isLoading: bottomType == .loading)
                }
            } else {
                if bottomType == .custom {
                    SBBMessage(title: title, text: text, imageType: topType == .info ? .info : .error, bottomImage: Image(sbbIcon: .arrows_circle_small), errorCode: error ? Text("Error: 404") : nil)
                } else if bottomType == .retry {
                    SBBMessage(title: title, text: text, imageType: topType == .info ? .info : .error, errorCode: error ? Text("Error: 404") : nil, retry: {})
                } else {
                    SBBMessage(title: title, text: text, imageType: topType == .info ? .info : .error, errorCode: error ? Text("Error: 404") : nil, isLoading: bottomType == .loading)
                }
            }
        }
    }
    
    private var settingsView: some View {
        VStack(spacing: 10) {
            HStack {
                VStack {
                    Text("Top")
                    Text("image")
                }
                SBBSegmentedPicker(selection: $topType, tags: [.info, .error, .custom]) {
                    Text("Info")
                    Text("Error")
                    Text("Custom")
                }
            }
            
            HStack {
                VStack {
                    Text("Bottom")
                    Text("image")
                }
                SBBSegmentedPicker(selection: $bottomType, tags: [.none, .loading, .retry, .custom]) {
                    Text("None")
                    Text("Loading")
                    Text("Retry")
                    Text("Custom")
                }
            }
            
            Toggle(isOn: $error) {
                Text("Error")
            }
            .toggleStyle(SBBSwitchStyle())
            .sbbScreenPadding(.horizontal)
        }
    }
    
    var body: some View {
        DemoWithModalSettingsView(colorScheme: $colorScheme, demoTitle: "Message", demoView: demoView, settingsView: settingsView)
    }
}

struct MessageDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageDemo(colorScheme: .constant(.light))
            MessageDemo(colorScheme: .constant(.dark)) 
        }
    }
}
