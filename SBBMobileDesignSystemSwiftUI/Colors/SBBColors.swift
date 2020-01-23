//
//  SBBColors.swift
//  SBBMobileDesignSystemSwiftUI
//
//  Created by Georgios Antoniadis on 23.01.20.
//  Copyright © 2020 SBB. All rights reserved.
//

import Foundation
import SwiftUI

public struct SBBColor {
    
    class SBBColorDummyClass { /* needed so that we can have the framework bundle via Bundle(for: SBBColorDummyClass.self) */ }
    
    public init() {}
    
    public static var red: Color { color(withString: "red") }
    
    private static func color(withString color: String) -> Color {
        return Color(UIColor(named: color, in: Bundle(for: SBBColorDummyClass.self), compatibleWith: nil)!)
    }
}
