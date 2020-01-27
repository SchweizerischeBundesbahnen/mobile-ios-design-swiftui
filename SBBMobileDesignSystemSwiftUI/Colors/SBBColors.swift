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
    
    public static var red: Color { color(withString: "Red") }
    public static var red125: Color { color(withString: "Red125") }
    public static var red150: Color { color(withString: "Red150") }
    public static var white: Color { color(withString: "White") }
    public static var milk: Color { color(withString: "Milk") }
    public static var cloud: Color { color(withString: "Cloud") }
    public static var silver: Color { color(withString: "Silver") }
    public static var aluminium: Color { color(withString: "Aluminium") }
    public static var platinum: Color { color(withString: "Platinum") }
    public static var cement: Color { color(withString: "Cement") }
    public static var graphite: Color { color(withString: "Graphite") }
    public static var storm: Color { color(withString: "Storm") }
    public static var smoke: Color { color(withString: "Smoke") }
    public static var metal: Color { color(withString: "Metal") }
    public static var granite: Color { color(withString: "Granite") }
    public static var anthracite: Color { color(withString: "Anthracite") }
    public static var iron: Color { color(withString: "Iron") }
    public static var black: Color { color(withString: "Black") }
    public static var blue: Color { color(withString: "Blue") }
    public static var sky: Color { color(withString: "Sky") }
    public static var night: Color { color(withString: "Night") }
    public static var violet: Color { color(withString: "Violet") }
    public static var autumn: Color { color(withString: "Autumn") }
    public static var orange: Color { color(withString: "Orange") }
    public static var peach: Color { color(withString: "Peach") }
    public static var lemon: Color { color(withString: "Lemon") }
    public static var green: Color { color(withString: "Green") }
    
    
    private static func color(withString color: String) -> Color {
        return Color(UIColor(named: color, in: Bundle(for: SBBColorDummyClass.self), compatibleWith: nil) ?? UIColor.white)
    }
}
