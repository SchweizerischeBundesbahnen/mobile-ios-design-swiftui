//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SegmentedPicker<Segment>: View where Segment: View {
     
    @Binding var selection: Int
    let childs : [Segment]
     
    public init(selection: Binding<Int>, @ArrayBuilder<Segment> content: () -> [Segment]) {
        self._selection = selection
        self.childs = content()
    }
    
    public var body: some View {
        ZStack {
            HStack {
                ForEach(0..<childs.count) { index in
                    if index == self.selection {
                        self.childs[index]
                            .background(Color.orange)
                    }
                    else {
                        self.childs[index]
                    }
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

// https://github.com/SwiftUIX/SwiftUIX/blob/master/Sources/Intermodular/Helpers/Swift/ArrayBuilder.swift
@_functionBuilder
public class ArrayBuilder<Element> {
    public static func buildBlock() -> [Element] {
        return []
    }
    
    public static func buildBlock(_ element: Element) -> [Element] {
        return [element]
    }
    
    public static func buildBlock(_ elements: Element...) -> [Element] {
        return elements
    }
}
