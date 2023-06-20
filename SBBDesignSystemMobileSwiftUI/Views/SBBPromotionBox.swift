//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI

public struct SBBPromotionBox: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.sizeCategory) var sizeCategory
    
    let newIn: String?
    let title: Text
    let text: Text
    
    @Binding var isPresented: Bool
    @State var textSize: CGSize = .zero
    
    public init(newIn: String? = nil, title: Text, text: Text, isPresented: Binding<Bool>) {
        self.newIn = newIn
        self.title = title
        self.text = text
        self._isPresented = isPresented
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
                                .frame(width: self.textSize.width + 40, height: 39)
                                .opacity(0.4)
                            Spacer()
                        }
                    }
                    .accessibility(hidden: true)
                    .offset(y: -19.5)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            title
                                .bold()
                                .sbbFont(.body)
                                .background(ViewGeometry())
                            Spacer()
                            Button(action: {
                                self.isPresented = false
                            }
                            ) {
                                Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .cross_medium : .cross_small)
                                    .foregroundColor(Color.sbbColor(.textBlack))
                            }
                        }
                        
                        text
                            .multilineTextAlignment(.leading)
                            .background(ViewGeometry())
                    }
                    .foregroundColor(Color.sbbColor(.textBlack))
                    .padding(16)
                    .background(
                        LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? [
                            Color(red: 46 / 255, green: 56 / 255, blue: 71 / 255),
                            Color(red: 59 / 255, green: 69 / 255, blue: 87 / 255),
                            Color(red: 59 / 255, green: 69 / 255, blue: 87 / 255),
                            Color(red: 32 / 255, green: 41 / 255, blue: 54 / 255)] : [
                                Color(red: 216 / 255, green: 236 / 255, blue: 237 / 255),
                                Color(red: 232 / 255, green: 243 / 255, blue: 247 / 255),
                                Color(red: 227 / 255, green: 239/255, blue: 243 / 255),
                                Color(red: 216 / 255, green: 236 / 255, blue: 237 / 255)]), startPoint: .top, endPoint: .bottom)
                        .overlay(
                            Image("noise", bundle: Helper.bundle)
                                .resizable(resizingMode: .tile)
                                .aspectRatio(contentMode: .fill)
                                .opacity(0.5))
                    )
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.sbbColor(colorScheme == .dark ? .charcoal : .white), lineWidth: 1)
                    )
                    .accessibility(hidden: true)
                    
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
                                        Text("Neu")
                                            .bold()
                                            .font(.system(size: 14))
                                            .fixedSize()
                                            .foregroundColor(.white)
                                            .background(ViewGeometry())
                                            .onPreferenceChange(ViewSizeKey.self) {
                                                self.textSize = $0
                                            }
                                    }
                                )
                                .frame(width: self.textSize.width + 20, height: 24)
                            Spacer()
                        }
                    }
                    .accessibility(hidden: true)
                    .offset(y: -12)
                }
                    .padding(.top, 19.5)
                    .sbbScreenPadding(.horizontal)
                    .accessibilityElement(children: .combine)
                    .accessibility(label: Text("\(newIn == nil ? "new".localized : (String.localizedStringWithFormat(NSLocalizedString("new in %@", tableName: nil, bundle: Helper.bundle, value: "", comment: ""), newIn!))) . ") + title + Text(" . ") + text + Text(" . ") + Text("close note".localized))
                    .accessibilityAddTraits(.isButton)
                    .accessibilityAction {
                        self.isPresented = false
                    }
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
