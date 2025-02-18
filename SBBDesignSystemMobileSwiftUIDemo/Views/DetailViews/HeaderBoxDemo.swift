//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct HeaderBoxDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var headerHeight: CGFloat = 0
    @State private var selectedContent: ContentType = .rectangle
    @State private var selectedCollapsibleContent: CollapsibleContentType = .none
    @State private var selectedAdditionalContent: AdditionalContentType = .none
    
    @State private var selectedPicker: Int = 0
    @State private var pickerSelected: Int = 0
    @State private var selectedSettings: Int = 0
    
    private enum ContentType {
        case rectangle
        case textAndIcon
        case textAndPicker
    }
    
    private enum CollapsibleContentType {
        case rectangle
        case longText
        case textAndPicker
        case none
    }
    
    private enum AdditionalContentType {
        case rectangle
        case textAndIcon
        case longText
        case none
    }
    
    @ViewBuilder
    private var settingsView: some View {
        if selectedSettings == 0 {
            smallSettingsView
        } else {
            longSettingsView
        }
    }
    
    private var smallSettingsView: some View {
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
            } else if selectedPicker == 1 {
                SBBRadioButtonGroup(selection: $selectedAdditionalContent, tags: [.rectangle, .textAndIcon, .longText, .none]) {
                    SBBRadioButton(text: Text("Rectangle placeholder"))
                    SBBRadioButton(text: Text("Text and icon"))
                    SBBRadioButton(text: Text("Long text"))
                    SBBRadioButton(text: Text("None"), showBottomLine: false)
                }
            }
            
            SBBSegmentedPicker(selection: $selectedSettings, tags: [0, 1]) {
                Text("Small content")
                Text("Large scrollable content")
            }
        }
        .sbbScreenPadding()
    }
    
    private var longSettingsView: some View {
        ScrollView {
            smallSettingsView
            ForEach(1..<101) { index in
                Text("Row \(index)")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
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
    }
    
    @ViewBuilder
    private var additionalContent: some View {
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
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.1)
                .fixedSize(horizontal: false, vertical: true)
        case .none:
            EmptyView()
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if selectedAdditionalContent == .none {
                SBBHeaderBox(content: { contentView }, extendNavigationBarBackground: true, pageContent: { settingsView })
            } else {
                SBBHeaderBox(content: { contentView }, additionalContent: { additionalContent }, extendNavigationBarBackground: true) { settingsView }
            }
            
            Spacer()
        }
        .navigationBarTitle("HeaderBox")
        .sbbStyle()
        .colorScheme(colorScheme)
    }
}

struct HeaderDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            HeaderBoxDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            HeaderBoxDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
