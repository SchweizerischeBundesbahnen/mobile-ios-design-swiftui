//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

@available(iOS 15.0, *)
struct HeaderBoxDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var headerHeight: CGFloat = 0
    @State private var selectedContent: ContentType = .rectangle
    @State private var selectedCollapsibleContent: CollapsibleContentType = .none
    @State private var selectedAdditionalContent: AdditionalContentType = .none
    
    @State private var selectedPicker: Int = 0
    @State private var pickerSelected: Int = 0
    @State private var selectedPageContent: PageContentType = .small
    @State private var isLoading: Bool = false
    @State private var refreshEnabled: Bool = false
    @State private var collapsedFromTop: Bool = false
    
    @AccessibilityFocusState private var currentFocus: String?
    
    private enum ContentType {
        case rectangle
        case textAndIcon
        case textAndPicker
    }
    
    private enum CollapsibleContentType {
        case rectangle
        case longText
        case textAndIcon
        case none
    }
    
    private enum AdditionalContentType {
        case rectangle
        case textAndIcon
        case longText
        case none
    }
    
    private enum PageContentType {
        case small
        case long
        case none
    }
    
    @ViewBuilder
    private func settingsView(_ focus: AccessibilityFocusState<String?>.Binding) -> some View {
        switch selectedPageContent {
        case .small:
            smallSettingsView(focus)
        case .long:
            longSettingsView(focus)
        case .none:
            EmptyView()
        }
    }
    
    private func smallSettingsView(_ focus: AccessibilityFocusState<String?>.Binding) -> some View {
        SBBFormGroup {
            SBBSegmentedPicker(selection: $selectedPicker, tags: [0, 1, 3]) {
                Text("Content")
                Text("Additional content")
                Text("Collpasible content")
            }
            .id("typePicker")
            .accessibilityFocused(focus, equals: "typePicker")
            if selectedPicker == 0 {
                SBBRadioButtonGroup(selection: $selectedContent, tags: [.rectangle, .textAndIcon, .textAndPicker]) {
                    SBBRadioButton(text: Text("Rectangle placeholder"))
                    SBBRadioButton(text: Text("Text and icon"))
                    SBBRadioButton(text: Text("Text and picker"), showBottomLine: false)
                }
                .id("contentTypeOptions")
                .accessibilityFocused(focus, equals: "contentTypeOptions")
            } else if selectedPicker == 1 {
                SBBRadioButtonGroup(selection: $selectedAdditionalContent, tags: [.rectangle, .textAndIcon, .longText, .none]) {
                    SBBRadioButton(text: Text("Rectangle placeholder"))
                    SBBRadioButton(text: Text("Text and icon"))
                    SBBRadioButton(text: Text("Long text"))
                    SBBRadioButton(text: Text("None"), showBottomLine: false)
                }
                .id("additionalContentOptions")
                .accessibilityFocused(focus, equals: "additionalContentOptions")
            } else {
                SBBRadioButtonGroup(selection: $selectedCollapsibleContent, tags: [.rectangle, .textAndIcon, .longText, .none]) {
                    SBBRadioButton(text: Text("Rectangle placeholder"))
                    SBBRadioButton(text: Text("Text and icon"))
                    SBBRadioButton(text: Text("Long text"))
                    SBBRadioButton(text: Text("None"), showBottomLine: false)
                }
                .disabled(selectedPageContent == .none)
                .id("collapsibleContentOptions")
                .accessibilityFocused(focus, equals: "collapsibleContentOptions")
                
                SBBSwitchItem(isOn: $collapsedFromTop, label: Text("Collapsed from top"), showLoading: false)
                    .id("collapsedSwitch")
                    .accessibilityFocused(focus, equals: "collapsedSwitch")
            }
            
            SBBSwitchItem(isOn: $isLoading, label: Text("Loading"), showLoading: false)
                .id("loadingSwitch")
                .accessibilityFocused(focus, equals: "loadingSwitch")
            
            SBBSwitchItem(isOn: $refreshEnabled, label: Text("Refresh on swipe down"), showLoading: false)
                .id("refreshSwitch")
                .accessibilityFocused(focus, equals: "refreshSwitch")
            
            SBBSegmentedPicker(selection: $selectedPageContent, tags: [.none, .small, .long]) {
                Text("No content")
                Text("Small content")
                Text("Large scrollable content")
            }
            .id("pageContentPicker")
            .accessibilityFocused(focus, equals: "pageContentPicker")
        }
        .sbbScreenPadding()
    }
    
    private func longSettingsView(_ focus: AccessibilityFocusState<String?>.Binding) -> some View {
        LazyVStack(spacing: 16) {
            smallSettingsView(focus)
            ForEach(1..<101) { index in
                Text("Row \(index)")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .id("row\(index)")
                    .accessibilityFocused(focus, equals: "row\(index)")
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
            .accessibilityElement(children: .combine)
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
            .accessibilityElement(children: .combine)
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
            .accessibilityElement(children: .combine)
        case .longText:
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.1)
                .fixedSize(horizontal: false, vertical: true)
        case .none:
            EmptyView()
        }
    }
    
    @ViewBuilder var collapsibleContent: some View {
        switch selectedCollapsibleContent {
        case .rectangle:
            Rectangle()
                .foregroundColor(Color.sbbColor(.placeholder))
                .frame(height: 20)
                .padding(.top, 16)
        case .longText:
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.1)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 16)
        case .textAndIcon:
            HStack {
                Image(sbbIcon: .sign_exclamation_point_small)
                    .foregroundStyle(Color.clear)
                Text("Collapsible text or information")
                Spacer()
            }
            .accessibilityElement(children: .combine)
        case .none:
            EmptyView()
        }
    }
    
    private var refresh: (() async -> Void)? {
        if refreshEnabled {
            {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
            }
        } else {
            nil
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if selectedPageContent == .none {
                VStack {
                    if selectedAdditionalContent == .none {
                        SBBHeaderBox(isLoading: isLoading, content: { contentView }, extendNavigationBarBackground: true)
                    } else {
                        SBBHeaderBox(isLoading: isLoading, content: { contentView }, additionalContent: { additionalContent }, extendNavigationBarBackground: true)
                    }
                    smallSettingsView($currentFocus)
                }
            } else {
                if selectedAdditionalContent == .none {
                    if selectedCollapsibleContent == .none {
                        SBBHeaderBox(isLoading: isLoading, content: { contentView }, extendNavigationBarBackground: true, pageContent: settingsView, pageContentScrollable: selectedPageContent == .long, refresh: refresh)
                    } else {
                        SBBHeaderBox(isLoading: isLoading, content: { contentView }, collapsibleContent: { collapsibleContent }, collapsedFromTop: collapsedFromTop, extendNavigationBarBackground: true, pageContent: settingsView, pageContentScrollable: selectedPageContent == .long, refresh: refresh)
                    }
                } else {
                    if selectedCollapsibleContent == .none {
                        SBBHeaderBox(isLoading: isLoading, content: { contentView }, additionalContent: { additionalContent }, extendNavigationBarBackground: true, pageContent: settingsView, pageContentScrollable: selectedPageContent == .long, refresh: refresh)
                    } else {
                        SBBHeaderBox(isLoading: isLoading, content: { contentView }, collapsibleContent: { collapsibleContent }, collapsedFromTop: collapsedFromTop, additionalContent: { additionalContent }, extendNavigationBarBackground: true, pageContent: settingsView, pageContentScrollable: selectedPageContent == .long, refresh: refresh)
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarTitle("HeaderBox")
        .sbbStyle()
        .sbbBackButtonStyle()
        .colorScheme(colorScheme)
    }
}

@available(iOS 15.0, *)
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
