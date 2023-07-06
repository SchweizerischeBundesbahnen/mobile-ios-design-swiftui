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
    @State var showSettings: Bool = false
    
    var body: some View {
        ZStack {
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
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(sbbIcon: .controls_medium)
                    }
                    .buttonStyle(SBBIconButtonStyle())
                    .padding(10)
                    
                }
                Spacer()
            }
        }
        .navigationBarTitle("Message")
        .sbbStyle()
        .colorScheme(colorScheme)
        .sbbModal(isPresented: $showSettings) {
            SBBModalView(title: Text("Settings"), style: .bottom, isPresented: $showSettings) {
                VStack(spacing: 10) {
                    HStack {
                        VStack {
                            Text("Top")
                                .font(.system(size: 14))
                            Text("image")
                                .font(.system(size: 14))
                        }
                        SBBSegmentedPicker(selection: $topType, tags: [.info, .error, .custom]) {
                            Text("Info")
                                .font(.system(size: 14))
                            Text("Error")
                                .font(.system(size: 14))
                            Text("Custom")
                                .font(.system(size: 14))
                        }
                    }
                    
                    HStack {
                        VStack {
                            Text("Bottom")
                                .font(.system(size: 14))
                            Text("image")
                                .font(.system(size: 14))
                        }
                        SBBSegmentedPicker(selection: $bottomType, tags: [.none, .loading, .retry, .custom]) {
                            Text("None")
                                .font(.system(size: 14))
                            Text("Loading")
                                .font(.system(size: 14))
                            Text("Retry")
                                .font(.system(size: 14))
                            Text("Custom")
                                .font(.system(size: 14))
                        }
                    }
                    
                    Toggle(isOn: $error) {
                        Text("Error")
                            .font(.system(size: 14))
                    }
                    .toggleStyle(SBBSwitchStyle())
                    .sbbScreenPadding(.horizontal)
                }
                .padding(10)
                .padding(.bottom, 16)
            }
        }
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
