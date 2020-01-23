//
//  ContentView.swift
//  SBBMobileDesignSystemSwiftUIDemo
//
//  Created by Georgios Antoniadis on 23.01.20.
//  Copyright © 2020 SBB. All rights reserved.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!").foregroundColor(SBBColor.red).bold()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
