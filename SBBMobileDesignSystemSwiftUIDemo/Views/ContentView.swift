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
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    SBBInfoView(image: Image(sbbName: "smartphone", size: .medium), text: Text("This demo app showcases all features of the Mobile Design System (MDS) SwiftUI Library."))
                    SBBSegmentedPicker(selection: $colorScheme, tags: [.light, .dark]) {
                        Text("light")
                        Text("dark")
                    }
                    SBBFormGroup(title: "Basics") {
                        NavigationLink(destination: ColorsView(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("Colors"))
                        }
                        NavigationLink(destination: TypographyView(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("Typography"))
                        }
                        NavigationLink(destination: IconDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("Icons"))
                        }
                    }
                    SBBFormGroup(title: "Elements") {
                        NavigationLink(destination: ButtonDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("Button"))
                        }
                        NavigationLink(destination: TextAreaView(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("TextArea"))
                        }
                        NavigationLink(destination: TextFieldView(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("TextField"))
                        }
                        NavigationLink(destination: CheckBoxView(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("CheckBox"))
                        }
                        NavigationLink(destination: RadioButtonView(colorScheme: self.$colorScheme).environmentObject(RadioButtonViewModel())) {
                            SBBListItem(label: Text("RadioButton"))
                        }
                        NavigationLink(destination: DividerViewDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("Divider"))
                        }
                        NavigationLink(destination: ListItemDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("ListItem"))
                        }
                        NavigationLink(destination: ToggleDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("Toggle"))
                        }
                        NavigationLink(destination: PaginationViewDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("Pagination"))
                        }
                        NavigationLink(destination: SegmentedPickerViewDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("SegmentedPicker"))
                        }
                    }
                    SBBFormGroup(title: "Modules") {
                        NavigationLink(destination: BubbleViewDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("BubbleView"))
                        }
                        NavigationLink(destination: InfoViewDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("InfoView"))
                        }
                        NavigationLink(destination: InfoViewCollapsibleDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("InfoViewCollapsible"))
                        }
                        NavigationLink(destination: FormGroupView(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("FormGroup"))
                        }
                        NavigationLink(destination: ModalViewDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("ModalView"))
                        }
                    }
                    SBBFormGroup(title: "PageTypes") {
                        NavigationLink(destination: OnboardingViewDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("OnboardingView"))
                        }
                    }
                    SBBFormGroup(title: "ViewModifiers") {
                        NavigationLink(destination: NavigationBarWithSBBIconDemo(colorScheme: self.$colorScheme)) {
                            SBBListItem(label: Text("NavigationBar with SBB Icon"))
                        }
                    }
                }
                    .padding(16)
            }
                .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
                .colorScheme(colorScheme)
                .navigationBarTitle("SBB MDS SwiftUI", displayMode: .inline)
                .navigationBarWithSBBIcon()
        }
            .navigationViewStyle(StackNavigationViewStyle())    // https://stackoverflow.com/questions/57905499/swiftui-code-is-working-in-iphone-but-blank-screen-in-ipad
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(colorScheme: .light)
                .previewDisplayName("Light")
            ContentView(colorScheme: .dark)
                .previewDisplayName("Dark")
        }
    }
}
