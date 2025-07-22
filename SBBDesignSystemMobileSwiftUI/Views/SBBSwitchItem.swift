//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//

import SwiftUI

/**
 A View that is used to display a single toggle item of a list.
 
 ## Overview
 You create a SBBSwitchItem by providing a label. You can optionally also provide an image, an additional action to perform, and error message
 
 ```swift
 SBBSwitchItem(isOn: $isOn, label: Text("Label"), image: Image(sbbIcon: .unicorn_small))
 ```
 ![SBBSwitchItemList](SBBSwitchItemList)
 
 ```swift
 SBBSwitchItem(isOn: $isOn, label: Text("Label"), image: Image(sbbIcon: .unicorn_small), type: .standalone)
 ```
 ![SBBSwitchItemStandalone](SBBSwitchItemStandalone)
 */
public struct SBBSwitchItem: View {
    
    private let label: Text
    private let labelAccessibility: Text?
    private let image: Image?
    private let footnote: Text?
    private let footnoteAccessibility: Text?
    private let errorMessage: Text?
    private let errorCode: Text?
    private let actionOnEnable: () async -> Bool
    private let actionOnDisable: () async -> Bool
    private let type: SBBSwitchItemType
    private let showTopLine: Bool
    private let showBottomLine: Bool
    private let showLoading: Bool
    
    @Binding private var isOn: Bool
    @State private var isLoading: Bool = false
    @State private var actionSuccess: Bool = true
    @State private var offsetX: CGFloat = 0
    
    @Environment(\.sizeCategory) private var sizeCategory
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public enum SBBSwitchItemType: Equatable {
        /// To be used in a list with top / bottom line
        case list
        /// To be used standalone with background color, corner radius
        case standalone
    }
    
    public init(isOn: Binding<Bool>, label: Text, labelAccessibility: Text? = nil, image: Image? = nil, footnote: Text? = nil, footnoteAccessibility: Text? = nil, showTopLine: Bool = false, showBottomLine: Bool = true, showLoading: Bool = true, errorMessage: Text? = nil, errorCode: Text? = nil, actionOnEnable: @escaping () async -> Bool = { true }, actionOnDisable: @escaping () async -> Bool = { true }) {
        self.label = label
        self.labelAccessibility = labelAccessibility
        self.image = image
        self.footnote = footnote
        self.footnoteAccessibility = footnoteAccessibility
        self.type = .list
        self.errorMessage = errorMessage
        self.errorCode = errorCode
        self.actionOnEnable = actionOnEnable
        self.actionOnDisable = actionOnDisable
        self.showTopLine = showTopLine
        self.showBottomLine = showBottomLine
        self.showLoading = showLoading
        self._isOn = isOn
    }
    
    public init(isOn: Binding<Bool>, label: Text, labelAccessibility: Text? = nil, image: Image? = nil, footnote: Text? = nil, footnoteAccessibility: Text? = nil, type: SBBSwitchItemType = .list, showLoading: Bool = true, errorMessage: Text? = nil, errorCode: Text? = nil, actionOnEnable: @escaping () async -> Bool = { true }, actionOnDisable: @escaping () async -> Bool = { true }) {
        self.label = label
        self.labelAccessibility = labelAccessibility
        self.image = image
        self.footnote = footnote
        self.footnoteAccessibility = footnoteAccessibility
        self.type = type
        self.errorMessage = errorMessage
        self.errorCode = errorCode
        self.actionOnEnable = actionOnEnable
        self.actionOnDisable = actionOnDisable
        self.showTopLine = false
        self.showBottomLine = type != .standalone ? true : false
        self.showLoading = showLoading
        self._isOn = isOn
    }
    
    public var body: some View {
        
        VStack(spacing: 0) {
            if showTopLine {
                SBBDivider()
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        if !sizeCategory.isAccessibilityCategory, let image {
                            image
                                .resizeToContentSizeCategory(originalHeight: 24)
                                .accessibilityHidden(true)
                        }
                        label
                            .sbbFont(.medium_light)
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibility(label: labelAccessibility ?? label)
                            .multilineTextAlignment(.leading)
                    }
                    .foregroundColor(Color.sbbColor(.textBlack).opacity(isLoading || !isEnabled ? 0.5 : 1.0))
                    
                    if let footnote = footnote {
                        footnote
                            .fixedSize(horizontal: false, vertical: true)
                            .sbbFont(.small_light)
                            .foregroundColor(.sbbColor(colorScheme == .dark ? .cement : .granite).opacity(isLoading || !isEnabled ? 0.5 : 1.0))
                            .accessibility(label: footnoteAccessibility ?? footnote)
                            .multilineTextAlignment(.leading)
                    }
                    
                    if let errorMessage {
                        errorMessage
                            .sbbFont(.small_light)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.sbbColor(.primary).opacity(isLoading || !isEnabled ? 0.5 : 1.0))
                    }
                    if let errorCode {
                        errorCode
                            .sbbFont(.xsmall_light)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.sbbColor(.primary).opacity(isLoading || !isEnabled ? 0.5 : 1.0))
                    }
                    
                    if !actionSuccess {
                        HStack {
                            Spacer()
                            Button(action: {
                                Task {
                                    if isOn {
                                        if self.showLoading {
                                            self.isLoading = true
                                        }
                                        async let actionSuccess = actionOnDisable()
                                        self.actionSuccess = await actionSuccess
                                        self.isLoading = false
                                    } else {
                                        if self.showLoading {
                                            self.isLoading = true
                                        }
                                        async let actionSuccess = actionOnEnable()
                                        self.actionSuccess = await actionSuccess
                                        self.isLoading = false
                                    }
                                }
                            }) {
                                Image(sbbIcon: .arrows_circle_small)
                            }
                            .buttonStyle(SBBIconButtonStyle())
                            .accessibilityLabel(Text("retry".localized))
                            Spacer()
                        }
                    }
                }
                .accessibilityElement(children: .combine)
                .disabled(isLoading || !isEnabled)
                
                Spacer()
                if actionSuccess {
                    Toggle("", isOn: $isOn)
                        .toggleStyle(SBBSwitchButtonStyle())
                        .disabled(isLoading || !isEnabled)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            
            ZStack(alignment: .bottom) {
                if showBottomLine {
                    SBBDivider()
                }
                if isLoading {
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.clear, Color.sbbColor(.primary)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 64, height: 2)
                            .offset(x: offsetX, y: geometry.size.height / 2)
                            .onAppear {
                                offsetX = 0
                                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                    self.offsetX = geometry.size.width
                                }
                            }
                    }
                }
            }
            .frame(height: 2)
            .accessibilityHidden(true)
        }
        .accessibilityElement(children: .combine)
        .onChange(of: isOn) { isOn in
            Task {
                if isOn {
                    self.isLoading = true
                    async let actionSuccess = actionOnDisable()
                    self.actionSuccess = await actionSuccess
                    self.isLoading = false
                } else {
                    self.isLoading = true
                    async let actionSuccess = actionOnEnable()
                    self.actionSuccess = await actionSuccess
                    self.isLoading = false
                }
            }
        }
        .background(type == .standalone ? Color.sbbColor(.viewBackground) : nil)
        .cornerRadius(type == .standalone ? 16 : 0)
    }
}
