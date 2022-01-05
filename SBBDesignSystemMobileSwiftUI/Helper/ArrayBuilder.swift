//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

@resultBuilder
public class ArrayBuilder<Element> {
    
    public static func buildBlock(_ elements: Element...) -> [Element] {
        return elements
    }
}
