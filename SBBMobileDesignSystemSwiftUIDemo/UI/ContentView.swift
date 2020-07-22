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
    @ObservedObject var onboardingViewModel: SBBOnboardingViewModel = FakeSBBOnboardingViewModels.hidden
    
    var body: some View {
        Group {
            if onboardingViewModel.state == .hidden {
                NavigationView {
                    VStack(spacing: 0) {
                        SBBSegmentedPicker(selection: $colorScheme, tags: [.light, .dark]) {
                            Text("light")
                            Text("dark")
                        }
                            .padding(16)
                            .background(SBBColor.background)
                        List {
                            Section {
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
                                NavigationLink(destination: InfoViewDemo(colorScheme: $colorScheme)) {
                                    Text("InfoView")
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
                            }
                            Section {
                                NavigationLink(destination: ButtonDemo(colorScheme: $colorScheme)) {
                                    Text("Button")
                                }
                                NavigationLink(destination: ListItemDemo(colorScheme: $colorScheme)) {
                                    Text("ListItem")
                                }
                                NavigationLink(destination: ToggleDemo(colorScheme: $colorScheme)) {
                                    Text("Toggle")
                                }
                                NavigationLink(destination: PaginationViewDemo(colorScheme: $colorScheme)) {
                                    Text("Pagination")
                                }
                                NavigationLink(destination: ModalViewDemo(colorScheme: $colorScheme)) {
                                    Text("Modal View")
                                }
                                Button(action: {
                                    self.onboardingViewModel.state = .startView
                                }) {
                                    Text("Onboarding")
                                }
                            }
                        }
                    }
                        .colorScheme(colorScheme)
                        .navigationBarTitle("SBB MDS SwiftUI", displayMode: .inline)
                }
                    .navigationViewStyle(StackNavigationViewStyle())    // https://stackoverflow.com/questions/57905499/swiftui-code-is-working-in-iphone-but-blank-screen-in-ipad
            } else {
                SBBOnboardingView(viewModel: onboardingViewModel)
                    .colorScheme(colorScheme)
            }
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
