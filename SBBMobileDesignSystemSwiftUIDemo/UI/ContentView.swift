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
    
    @State var colorScheme: ColorScheme = .light
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section(header: Text("ColorScheme")) {
                        SBBSegmentedPicker(selection: $colorScheme, tags: [.light, .dark]) {
                            Text("light")
                            Text("dark")
                        }
                    }
                }
                    .frame(minHeight: 0, maxHeight: 100)
                List {
                    NavigationLink(destination: ColorsView(colorScheme: $colorScheme)) {
                        Text("Colors")
                    }
                    NavigationLink(destination: TypographyView(colorScheme: $colorScheme)) {
                        Text("Typography")
                    }
                    NavigationLink(destination: DividerViewDemo(colorScheme: $colorScheme)) {
                        Text("Divider")
                    }
                    NavigationLink(destination: BubbleViewDemo(colorScheme: $colorScheme)) {
                        Text("BubbleView")
                    }
                    NavigationLink(destination: SegmentedPickerViewDemo(colorScheme: $colorScheme)) {
                        Text("SegmentedPicker")
                    }
                    NavigationLink(destination: TextAreaView(colorScheme: $colorScheme)) {
                        Text("TextArea")
                    }
                    NavigationLink(destination: TextFieldView(colorScheme: $colorScheme)) {
                        Text("TextField")
                    }
                    NavigationLink(destination: CheckBoxView(colorScheme: $colorScheme)) {
                        Text("CheckBox")
                    }
                    NavigationLink(destination: FormGroupView(colorScheme: $colorScheme)) {
                        Text("FormGroup")
                    }
                    NavigationLink(destination: ButtonDemo(colorScheme: $colorScheme)) {
                        Text("Button")
                    }
                }
            }
                .colorScheme(colorScheme)
                .navigationBarTitle("SBB MDS SwiftUI", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(colorScheme: .light)
                .previewDisplayName("Light")
            ContentView(colorScheme: .dark)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
