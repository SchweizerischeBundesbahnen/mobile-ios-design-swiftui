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
    static let bundleId = "ch.sbb.personenverkehr.SBBMobileDesignSystemSwiftUI"
    
    public init() {}
    
    public static var red: Color { color(withString: "red") }
    
    private static func color(withString color: String) -> Color {
        return Color(UIColor(named: color, in: Bundle(identifier: bundleId), compatibleWith: nil)!)
    }
}
