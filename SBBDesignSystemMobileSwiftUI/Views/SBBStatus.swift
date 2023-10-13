//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI

/**
 A  View that is used to show a status.
 
 ## Overview
 You create a SBBStatus by providing its type ``StatusType``:
 ```swift
 var body: some View {
    SBBStatus(statusType: .alert)
 }
 ```
 ![SBBStatus](SBBStatus)
 */
public struct SBBStatus: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.sizeCategory) var sizeCategory
    
    let statusType: StatusType
    let showText: Bool
    
    
    /**
     Returns a SBBStatus.
     
     - Parameters:
        - statusType: The type of status.
        - noText: Whether to also display the corresponding text.
     */
    public init(statusType: StatusType, showText: Bool = true) {
        self.statusType = statusType
        self.showText = showText
    }
    
    private var backgroundColor: Color {
        switch statusType {
        case .alert:
            return Color.sbbColor(.red)
        case .warning:
            return Color.sbbColor(.peach)
        case .success:
            return Color.sbbColor(.green)
        case .info:
            return Color.sbbColor(.smoke)
        }
    }
    
    private var text: some View {
        switch statusType {
        case .alert:
            return Text("alert".localized)
        case .warning:
            return Text("warning".localized)
            
        case .success:
            return Text("success".localized)
        case .info:
            return Text("info".localized)
        }
    }
    
    private var icon: some View {
        switch statusType {
        case .alert:
            return Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .circle_cross_medium : .circle_cross_small)
                .foregroundColor(Color.sbbColor(.white))
        case .warning:
            return Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .circle_exclamation_point_medium : .circle_exclamation_point_small)
                .foregroundColor(Color.sbbColor(.black))
        case .success:
            return Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .circle_tick_medium : .circle_tick_small)
                .foregroundColor(Color.sbbColor(.white))
        case .info:
            return Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .circle_information_medium : .circle_information_small)
                .foregroundColor(Color.sbbColor(.white))
        }
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            icon
                .frame(minWidth: 28, minHeight: 28)
            if showText {
                VStack {
                    text
                        .foregroundColor(Color.sbbColor(.textBlack))
                        .sbbFont(.body)
                }
                .padding(8)
                .background(Color.sbbColor(colorScheme == .dark ? .black : .white).opacity(colorScheme == .dark ? 0.85 : 0.95))
                .cornerRadius(1, corners: [.bottomRight, .topRight])
                .padding(1)
            }
        }
        .background(backgroundColor)
        .cornerRadius(2)
    }
}

struct SBBStatus_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                SBBStatus(statusType: .alert)
                SBBStatus(statusType: .warning)
                SBBStatus(statusType: .success)
                SBBStatus(statusType: .info)
            }
            .previewDisplayName("Normal")
            VStack {
                SBBStatus(statusType: .alert)
                SBBStatus(statusType: .warning)
                SBBStatus(statusType: .success)
                SBBStatus(statusType: .info)
            }
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .previewDisplayName("Accessibility")
        }
        .previewLayout(.sizeThatFits)
    }
}
