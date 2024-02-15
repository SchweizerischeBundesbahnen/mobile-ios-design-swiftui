//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct HeaderDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var headerHeight: CGFloat = 0
    @State private var selectedContent: ContentType = .rectangle
    @State private var selectedAdditionalContent: AdditionalContentType = .rectangle
    
    @State private var selectedPicker: Int = 0
    @State private var pickerSelected: Int = 0
    
    private enum ContentType {
        case rectangle
        case textAndIcon
        case textAndPicker
    }
    
    private enum AdditionalContentType {
        case rectangle
        case textAndIcon
        case longText
        case none
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 8) {
                ScrollView {
                    SBBFormGroup {
                        SBBSegmentedPicker(selection: $selectedPicker, tags: [0, 1]) {
                            Text("Content")
                            Text("Additional content")
                        }
                        if selectedPicker == 0 {
                            SBBRadioButtonGroup(selection: $selectedContent, tags: [.rectangle, .textAndIcon, .textAndPicker]) {
                                SBBRadioButton(text: Text("Rectangle placeholder"))
                                SBBRadioButton(text: Text("Text and icon"))
                                SBBRadioButton(text: Text("Text and picker"), showBottomLine: false)
                            }
                        } else {
                            SBBRadioButtonGroup(selection: $selectedAdditionalContent, tags: [.rectangle, .textAndIcon, .longText, .none]) {
                                SBBRadioButton(text: Text("Rectangle placeholder"))
                                SBBRadioButton(text: Text("Text and icon"))
                                SBBRadioButton(text: Text("Long text"))
                                SBBRadioButton(text: Text("None"), showBottomLine: false)
                            }
                        }
                    }
                    .sbbScreenPadding()
                    
                    SBBHeader(content: {
                        switch selectedContent {
                        case .rectangle:
                            Rectangle()
                                .foregroundColor(Color.sbbColor(.placeholder))
                                .frame(height: 24)
                        case .textAndIcon:
                            HStack {
                                Image(sbbIcon: .city_small)
                                Text("Some title")
                            }
                        case .textAndPicker:
                            VStack(alignment: .leading) {
                                Text("Some title")
                                SBBSegmentedPicker(selection: $pickerSelected, tags: [0, 1]) {
                                    Text("Option 1")
                                        .tag(0)
                                    Text("Option 2")
                                        .tag(1)
                                }
                            }
                        }
                    }, additionalContent: {
                        switch selectedAdditionalContent {
                        case .rectangle :
                            Rectangle()
                                .foregroundColor(Color.sbbColor(.placeholder))
                                .frame(height: 20)
                        case .textAndIcon:
                            HStack {
                                Image(sbbIcon: .sign_exclamation_point_small)
                                Text("Additional text or information")
                                Spacer()
                                Image(sbbIcon: .circle_information_small)
                            }
                        case .longText:
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                        case .none:
                            EmptyView()
                        }
                    }, extendNavigationBarBackground: false)
                }
            }
            .padding(.top, headerHeight + 16)
            
            SBBHeader(content: {
                Text("Header examples").sbbFont(.medium_bold)
            }, additionalContent: {
                Text("Header can be created with any content and additional content. Here are some examples.")
            })
                .viewHeight($headerHeight)
        }
        .navigationBarTitle("Header")
        .sbbStyle()
        .colorScheme(colorScheme)
    }
}

struct HeaderDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            HeaderDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            HeaderDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
