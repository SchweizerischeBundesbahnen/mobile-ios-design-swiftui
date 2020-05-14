//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBBubbleView: View {
    
    private let image: Image
    private let title: Text
    private let titleAccessibility: Text?
    private let subtitle: Text?
    private let subtitleAccessibility: Text?
    private let detail: [Text]?
    private let detailAccessibility: [Text]?
    @Binding private var expanded: Bool
    
    public init(image: Image, title: Text, titleAccessibility: Text? = nil, subtitle: Text? = nil, subtitleAccessibility: Text? = nil, detail: [Text]? = nil, detailAccessibility: [Text]? = nil, expanded: Binding<Bool>) {
        self.image = image
        self.title = title
        self.titleAccessibility = titleAccessibility
        self.subtitle = subtitle
        self.subtitleAccessibility = subtitleAccessibility
        self.detail = detail
        self.detailAccessibility = detailAccessibility
        self._expanded = expanded
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(SBBColor.red)
                .frame(idealWidth: .infinity, minHeight: 35, maxHeight: 35)
            HStack {
                HStack(alignment: .top, spacing: 16) {
                    image
                        .frame(width: 36, height: 36, alignment: .center)
                        .accessibility(hidden: true)
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center) {
                                title
                                    .sbbFont(.titleDefault)
                                    .accessibility(label: self.titleAccessibility ?? self.title)
                                    .padding([.bottom, .top], 8)
                                Spacer()
                                if (self.detail != nil) {
                                    Group {
                                        Image("chevron_small_up", bundle: Helper.bundle)
                                            .rotationEffect(.degrees(self.expanded ? 0 : 180))
                                    }
                                        .accessibility(hidden: true)
                                        .frame(width: 32, height: 32)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(SBBColor.border))
                                }
                            }
                            if (self.subtitle != nil) {
                                subtitle!
                                    .sbbFont(.body)
                                    .accessibility(label: self.subtitleAccessibility ?? self.subtitle!)
                            }
                        }
                        if (self.detail != nil) && self.expanded {
                            SBBDivider()
                            ForEach(self.detail!.indices, id: \.self) { index in
                                self.detail![index]
                                    .sbbFont(.body)
                                    .accessibility(label: (self.detailAccessibility?.indices.contains(index) ?? false) ? self.detailAccessibility![index] : self.detail![index])
                            }
                        }
                    }
                        .accessibilityElement(children: .combine)   // TODO - delete once SwiftUI bug is solved
                }
                    .disabled(self.detail == nil)
                    .padding(16)
                    .background(SBBColor.tabViewBackground)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.1), radius: 5)
                    .accentColor(SBBColor.textBlack)
                    //.accessibilityElement(children: .combine) / TODO - uncomment once SwiftUI bug (.combine does not reload voiceover if children element Strings are changed) is solved
                    .accessibility(hint: ((self.detail == nil) ? Text("") : self.expanded ? Text("collapse".localized) : Text("expand".localized)))
            }
                .padding(.horizontal, 16)
                .onTapGesture {
                    withAnimation{
                        self.expanded.toggle()
                    }
                }
        }
    }
}

struct SBBBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBBubbleView(image: Image(systemName: "car"), title: Text("IC6 nach Basel"), expanded: .constant(true))
                .previewDisplayName("Title only")
            SBBBubbleView(image: Image(systemName: "car"), title: Text("Biel / Bienne"), subtitle: Text("Gleis 2 und 3."), expanded: .constant(true))
                .previewDisplayName("Subtitle")
            SBBBubbleView(image: Image(systemName: "car"), title: Text("IC6 nach Basel"), detail: [Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")], expanded: .constant(true))
                .previewDisplayName("Detail")
            SBBBubbleView(image: Image(systemName: "car"), title: Text("IC6 nach Basel"), detail: [Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")], expanded: .constant(true))
                .previewDisplayName("Detail dark")
                .environment(\.colorScheme, .dark)
            SBBBubbleView(image: Image(systemName: "car"), title: Text("IC6 nach Basel"), detail: [Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03."), Text("ca. +12'").foregroundColor(SBBColor.red).font(.sbbTitleDefault)], expanded: .constant(true))
                .previewDisplayName("Detail")
        }
            .previewLayout(.sizeThatFits)
    }
}
