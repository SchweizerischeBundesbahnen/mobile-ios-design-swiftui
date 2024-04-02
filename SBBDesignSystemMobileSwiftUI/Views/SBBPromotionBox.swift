//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI


/**
 A  View that is used to display a promotion box.
 
 ## Overview
 You create a SBBPromotionBox by providing a title and a text message, both as Text, and a binding for a boolean that decides wether the promotion box is displayed or not. Additionnally, one can use the parameter `newIn: String?` to provide for example the name of the app, the VoiceOver then reads: "New in DSM App. New feature. There is a new feature. Close this note. Button.".
 
 ```swift
 
 @State var isPresented: Bool = true
 
 var body: some View {
    SBBPromotionBox(newIn: "DSM App", title: Text("New feature"), text: Text("There is a new feature", isPresented: $isPresented)
 }
 ```
 ![SBBPromotionBox](SBBPromotionBox)
 */
public struct SBBPromotionBox: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.sizeCategory) var sizeCategory
    
    let newIn: String?
    let title: Text
    let text: Text
    let onClick: (()->())?
    var closeAccessibility: String = "close note".localized
    var clickAccessibility: String = "more info".localized
    
    @Binding var isPresented: Bool
    @State var newSize: CGSize = .zero
    @State var textSize: CGSize = .zero
    
    
    /**
     Returns a SBBPromotionBox.
     
     - Parameters:
        - newIn: A  optional string, for example the name of the app, to be read by VoiceOver.
        - title: The Text to display as the title of the message.
        - text: The Text to display as the title of the message.
        - isPresented: Whether the promotion box is displayed.
        - onClick: An action to be performed on click.
        -  closeAccessibility: The accessibility label to announce the close action. Default: "close".
        -  clickAccessibility: The accessibility label to announce the button action. Default: "more information".
     */
    public init(newIn: String? = nil, title: Text, text: Text, isPresented: Binding<Bool>, onClick: (() ->())? = nil, closeAccessibility: String? = nil, clickAccessibility: String? = nil) {
        self.newIn = newIn
        self.title = title
        self.text = text
        self._isPresented = isPresented
        self.onClick = onClick
        if let closeAccessibility = closeAccessibility {
            self.closeAccessibility = closeAccessibility
        }
        if let clickAccessibility = clickAccessibility {
            self.clickAccessibility = clickAccessibility
        }
    }
    
    private var iconSize: CGFloat {
        return sizeCategory.isAccessibilityCategory ? 36 : 24
    }
    
    private var topView: some View {
        HStack {
            title
                .bold()
                .sbbFont(.medium_light)
            Spacer()
            Button(action: {
                self.isPresented = false
            }
            ) {
                Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .cross_medium : .cross_small)
                    .foregroundColor(Color.sbbColor(.textBlack))
            }
        }
    }
    
    private var bottomView: some View {
        HStack(alignment: .top) {
            text
                .multilineTextAlignment(.leading)
                .viewSize($textSize)
            
            if let onClick = onClick {
                Spacer()
                Button(action: {
                    onClick()
                }) {
                    Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .chevron_right_medium : .chevron_small_right_medium)
                        .foregroundColor(Color.sbbColor(.textBlack))
                        .frame(width: iconSize, height: textSize.height)
                }
            }
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            topView
            bottomView
        }
    }
    
    public var body: some View {
        Group {
            if isPresented {
                ZStack(alignment: .top) {
                    // Red shadow
                    VStack {
                        HStack {
                            Spacer()
                            Rectangle()
                                .fill(Color.sbbColor(.red))
                                .cornerRadius(20)
                                .frame(width: self.newSize.width + 40, height: 39)
                                .opacity(0.4)
                            Spacer()
                        }
                    }
                    .accessibility(hidden: true)
                    .offset(y: -19.5)
                    
                    Group {
                        if let onClick = onClick {
                            ZStack(alignment: .top) {
                                contentView
                                    .accessibilityElement(children: .combine)
                                    .accessibilityAddTraits(.isButton)
                                    .accessibilityAction {
                                        onClick()
                                    }
                                    .accessibility(label: Text("\(newIn == nil ? "new".localized : (String.localizedStringWithFormat(NSLocalizedString("new in %@", tableName: nil, bundle: Helper.bundle, value: "", comment: ""), newIn!))) . ") + title + Text(" ") + text + Text(". \(clickAccessibility.localized)"))
                                    .accessibility(sortPriority: 1)
                                
                                HStack {
                                    Spacer()
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(width: iconSize, height: iconSize)
                                        .accessibilityElement(children: .combine)
                                        .accessibilityAddTraits(.isButton)
                                        .accessibilityAction {
                                            self.isPresented = false
                                        }
                                        .accessibility(label: Text(closeAccessibility.localized))
                                }
                            }
                            .accessibilityElement(children: .contain)
                        } else {
                            contentView
                                .accessibilityElement(children: .combine)
                                .accessibility(label: Text("\(newIn == nil ? "new".localized : (String.localizedStringWithFormat(NSLocalizedString("new in %@", tableName: nil, bundle: Helper.bundle, value: "", comment: ""), newIn!))) . ") + title + Text(" ") + text + Text(" \(closeAccessibility.localized)"))
                                .accessibilityAddTraits(.isButton)
                                .accessibilityAction {
                                    self.isPresented = false
                                }
                        }
                    }
                    .foregroundColor(Color.sbbColor(.textBlack))
                    .padding(16)
                    .background(
                        LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? [
                            Color(red: 0.125, green: 0.161, blue: 0.212),
                            Color(red: 0.18, green: 0.22, blue: 0.278),
                            Color(red: 0.125, green: 0.161, blue: 0.212)] : [
                                Color(red: 0.846, green: 0.926, blue: 0.93),
                                Color(red: 0.91, green: 0.954, blue: 0.97),
                                Color(red: 0.89, green: 0.937, blue: 0.953),
                                Color(red: 0.84, green: 0.926, blue: 0.93)]), startPoint: .top, endPoint: .bottom)
                        .overlay(
                            Image("noise", bundle: Helper.bundle)
                                .resizable(resizingMode: .tile)
                                .aspectRatio(contentMode: .fill)
                                .compositingGroup()
                                .blendMode(.overlay))
                        .accessibility(hidden: true)
                    )
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.sbbColor(colorScheme == .dark ? .charcoal : .white), lineWidth: 1)
                            .accessibility(hidden: true)
                    )
                    
                    // Red top bubble
                    VStack {
                        HStack {
                            Spacer()
                            Rectangle()
                                .fill(Color.sbbColor(.red))
                                .cornerRadius(20)
                                .overlay(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.sbbColor(colorScheme == .dark ? .charcoal : .white), lineWidth: 1)
                                        Text("new".localized)
                                            .bold()
                                            .font(.system(size: 14))
                                            .fixedSize()
                                            .foregroundColor(.white)
                                            .viewSize(self.$newSize)
                                    }
                                )
                                .frame(width: self.newSize.width + 20, height: 24)
                            Spacer()
                        }
                    }
                    .accessibility(hidden: true)
                    .offset(y: -12)
                }
                    .padding(.top, 19.5)
                    
            } else {
                EmptyView()
            }
        }
    }
}


struct SBBPromotionBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBPromotionBox(title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), isPresented: .constant(true))
        }
        .previewLayout(.sizeThatFits)
    }
}
