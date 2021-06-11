//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/// SBBModalView TitleAlignment.
public enum SBBModalViewTitleAlignment {
    /// SBBModalView title alignment on the leading edge edge of the View.
    case leading
    /// SBBModalView title alignment horizontally centered inside View.
    case center
}

/// A  View that is displayed modally above another View, typically using the .sheet() or sbbModal() ViewModifiers.
public struct SBBModalView<Content>: View where Content: View {
    
    /// SBBModalView Style.
    public enum Style {
        /// Popup SBBModalView Style (to be used with the .sbbModal() ViewModifier)
        case popup
        /// Sheet SBBModalView Style (to be used with the .sbbModal() ViewModifier)
        case sheet
        /// Full SBBModalView Style (to be used with the .sheet() ViewModifier)
        case full
    }

    private let title: Text
    private let style: Style
    private let titleAlignment: SBBModalViewTitleAlignment
    @Binding private var isPresented: Bool
    @Binding private var showBackButton: Bool
    private let actionOnBackButtonTouched: (() -> ())?
    private let content: Content

    /**
     Returns a SBBModalView displaying a title, custom content and an optional close button at the top-trailing edge.
     
     - Parameters:
        - title: The Text to display as title.
        - style: The style of the SBBModalView depending on how it is presented.
        - showBackButton: An optional flag, controlling if a back button should be displayed at the top-trailing edge. Allowing navigation inside a SBBModalView.
        - actionOnBackButtonTouched: An optional action to be performed open touch events on the back button.
        - content: A custom VIew to be shown underneath the title.
     */
    public init(title: Text, style: Style = .full, titleAlignment: SBBModalViewTitleAlignment = .leading, isPresented: Binding<Bool>, showBackButton: Binding<Bool> = .constant(false), actionOnBackButtonTouched: (() -> ())? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.style = style
        self.titleAlignment = titleAlignment
        self._isPresented = isPresented
        self._showBackButton = showBackButton
        self.actionOnBackButtonTouched = actionOnBackButtonTouched
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if style == .sheet {
                Spacer()
            }
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    if showBackButton {
                        Button(action: {
                            self.actionOnBackButtonTouched?()
                        }) {
                            Image(sbbName: "chevron-small-right", size: .small)
                                .rotationEffect(Angle(degrees: 180))
                                .accessibility(label: Text("back".localized))
                        }
                            .buttonStyle(SBBIconButtonStyle(size: .small))
                    } else if titleAlignment == .center {
                        Spacer()
                            .frame(width: 32)
                    }
                    if titleAlignment == .center {
                        Spacer()
                    }
                    title
                        .padding(.top, 7)
                        .sbbFont(.titleModul)
                        .accessibility(addTraits: .isHeader)
                    Spacer()
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Image(sbbName: "cross", size: .small)
                            .accessibility(label: Text("close".localized))
                    }
                        .buttonStyle(SBBIconButtonStyle(size: .small))
                }
                    .padding(16)
                content
                    .padding(.bottom, style == .popup ? 16 : 0)
            }
                .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
                .cornerRadius(style != .full ? 16 : 0, corners: [.topLeft, .topRight])
                .cornerRadius(style == .popup ? 16 : 0, corners: [.bottomLeft, .bottomRight])
                .background(    // we need to reapply background color for styles, where not all edges are rounded (.cornerRadius clips the view)
                    (style == .popup ? Color.clear : Color.sbbColor(.background))
                        .offset(y: 16)
                        .clipped()
                        .edgesIgnoringSafeArea(.bottom)
                )
                .padding(.horizontal, style == .popup ? 16 : 0)
        }
            .background(Color.clear)
    }
}

struct SBBModalView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                SBBModalView(title: Text("Modal View"), style: .popup, isPresented: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Popup, light, leading alignment")
                SBBModalView(title: Text("Modal View"), style: .popup, isPresented: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Popup, dark, leading alignment")
                    .environment(\.colorScheme, .dark)
                SBBModalView(title: Text("Modal View"), style: .popup, titleAlignment: .center, isPresented: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Popup, light, center alignment")
                SBBModalView(title: Text("Modal View"), style: .popup, titleAlignment: .center, isPresented: .constant(true), showBackButton: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Popup, light, Back Button")
            }
            Group {
                SBBModalView(title: Text("Modal View"), style: .sheet, isPresented: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Sheet, light, leading alignment")
                SBBModalView(title: Text("Modal View"), style: .sheet, isPresented: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Sheet, dark, leading alignment")
                    .environment(\.colorScheme, .dark)
                SBBModalView(title: Text("Modal View"), style: .sheet, titleAlignment: .center, isPresented: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Sheet, light, center alignment")
                SBBModalView(title: Text("Modal View"), style: .sheet, titleAlignment: .center, isPresented: .constant(true), showBackButton: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Sheet, light, Back Button")
            }
                .previewLayout(.fixed(width: 400, height: 200))
            Group {
                SBBModalView(title: Text("Modal View"), style: .full, isPresented: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Full, light, leading alignment")
                SBBModalView(title: Text("Modal View"), style: .full, isPresented: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Full, dark, leading alignment")
                    .environment(\.colorScheme, .dark)
                SBBModalView(title: Text("Modal View"), style: .full, titleAlignment: .center, isPresented: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Full, light, center alignment")
                SBBModalView(title: Text("Modal View"), style: .full, titleAlignment: .center, isPresented: .constant(true), showBackButton: .constant(true)) {
                    Text("Custom content")
                }
                    .previewDisplayName("Full, light, Back Button")
            }
        }
            .previewLayout(.sizeThatFits)
    }
}
