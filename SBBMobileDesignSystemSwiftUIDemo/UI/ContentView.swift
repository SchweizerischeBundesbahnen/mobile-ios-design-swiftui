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
        NavigationView {
            List {
                NavigationLink(destination: ColorsView()) {
                    Text("Colors")
                }
                NavigationLink(destination: TypographyView()) {
                    Text("Typography")
                }
                NavigationLink(destination: BubbleViewDemo()) {
                    Text("BubbleView")
                }
            }
                .modifier(SBBNavigationBar())
                .navigationBarTitle("SBB MDS SwiftUI", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("Light")
           ContentView()
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
