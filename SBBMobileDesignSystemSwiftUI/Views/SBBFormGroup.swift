//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBFormGroup: View {
    
    private let title: String
    private let rows: [AnyView]
    
    public init<C0: View>(title: String = "", @ViewBuilder content: () -> C0) {
        self.title = title
        let row = AnyView(content())
        rows = [row]
    }
    
    public init<C0: View, C1: View>(title: String = "", @ViewBuilder content: () -> TupleView<(C0, C1)>) {
        self.title = title
        let tuple = content().value
        rows = [AnyView(tuple.0), AnyView(tuple.1)]
    }
    
    public init<C0: View, C1: View, C2: View>(title: String = "", @ViewBuilder content: () -> TupleView<(C0, C1, C2)>) {
        self.title = title
        let tuple = content().value
        rows = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2)]
    }
    
    public init<C0: View, C1: View, C2: View, C3: View>(title: String = "", @ViewBuilder content: () -> TupleView<(C0, C1, C2, C3)>) {
        self.title = title
        let tuple = content().value
        rows = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3)]
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !title.isEmpty {
                Text(title)
                    .sbbFont(.body)
                    .padding(16)
            }
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0 ..< rows.count) { index in
                    HStack {
                        self.rows[index]
                        Spacer()
                    }
                    if index < self.rows.count - 1 {
                        SBBDivider().padding(.leading, 16)
                    }
                }
            }
            .background(SBBColor.controlBackground)
            .cornerRadius(16)
        }
    }
}

struct SBBFormGroup_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBFormGroup() {
                Text("Text").sbbFont(.body).padding(16)
            }
            .previewDisplayName("One row, no title, light")
            SBBFormGroup(title: "Title") {
                Text("Text").sbbFont(.body).padding(16)
                SBBTextField(text: .constant("Value"), title: "title")
                SBBCheckBox(isOn: .constant(true), label: "Placeholder")
            }
            .previewDisplayName("Light")
            SBBFormGroup(title: "Title") {
                Text("Text").sbbFont(.body).padding(16)
                SBBTextField(text: .constant("Value"), title: "title")
                SBBCheckBox(isOn: .constant(true), label: "Placeholder")
            }
            .previewDisplayName("Dark")
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
