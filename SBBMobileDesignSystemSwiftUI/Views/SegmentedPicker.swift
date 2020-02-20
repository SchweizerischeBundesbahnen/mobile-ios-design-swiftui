//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SegmentedPicker<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    
    @Binding var selection: SelectionValue
    let items: [AnyView]
    
    public init(selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) { // this init will be used for any non-supported number of TupleView
        self._selection = selection
        let views = content()
        self.items = [AnyView(views)]
    }
    
    // MARK: TupleView support (currently min 2 elements, max 4 elements)
    /*
    public init(@ViewBuilder content: () -> TupleView<(Content, Content)>) {
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1)]
    }
    
    public init(@ViewBuilder content: () -> TupleView<(Content, Content, Content)>) {
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2)]
    }
    
    public init(@ViewBuilder content: () -> TupleView<(Content, Content, Content, Content)>) {
        let views = content().value
        self.items = [AnyView(views.0), AnyView(views.1), AnyView(views.2), AnyView(views.3)]
    }
    */
    public var body: some View {
        ZStack {
            HStack {
                ForEach(0..<items.count) { index in
                    self.items[index]
                }
            }
        }
            .frame(maxWidth: .infinity)
            .background(SBBColor.divider)
    }
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SegmentedPicker(selection: .constant(0)) {
                Text("Tab1")
                Text("Tab2")
            }
                .previewDisplayName("Light")
            SegmentedPicker(selection: .constant(0)) {
                Text("Tab1")
                Text("Tab2")
            }
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
