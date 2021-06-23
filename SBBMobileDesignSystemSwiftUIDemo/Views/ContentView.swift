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
    @State var contentSizeCategory: ContentSizeCategory = .medium
    @EnvironmentObject var modalViewModel: SBBModalViewModel
    @EnvironmentObject var bannerViewModel: BannerViewModel
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        Group {
            if onboardingViewModel.onboardingState == .hidden {
                NavigationView {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 16) {
                            SBBInfoView(image: Image(sbbName: "smartphone", size: .medium), text: Text("This demo app showcases all features of the Design System Mobile (DSM) SwiftUI Library."))
                            SBBSegmentedPicker(selection: $colorScheme, tags: [.light, .dark]) {
                                Text("light")
                                Text("dark")
                            }
                            SBBSegmentedPicker(selection: $contentSizeCategory, tags: [.extraSmall, .medium, .extraExtraExtraLarge, .accessibilityExtraExtraExtraLarge]) {
                                Text("XS")
                                Text("M")
                                Text("XXXL")
                                Text("aXXXL")
                            }
                            SBBFormGroup(title: "Basics") {
                                NavigationLink(destination: ColorsView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Colors"))
                                }
                                NavigationLink(destination: TypographyView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Typography"))
                                }
                                NavigationLink(destination: IconDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Icons"), showBottomLine: false)
                                }
                            }
                            SBBFormGroup(title: "Elements") {
                                Group {
                                    NavigationLink(destination: ButtonDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("Button"))
                                    }
                                    NavigationLink(destination: TextAreaView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("TextArea"))
                                    }
                                    NavigationLink(destination: TextFieldView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory).environmentObject(TextFieldViewModel())) {
                                        SBBListItem(label: Text("TextField"))
                                    }
                                    NavigationLink(destination: CheckBoxView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("CheckBox"))
                                    }
                                    NavigationLink(destination: RadioButtonView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory).environmentObject(RadioButtonViewModel())) {
                                        SBBListItem(label: Text("RadioButton"))
                                    }
                                    NavigationLink(destination: DividerViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("Divider"))
                                    }
                                    NavigationLink(destination: ListItemDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("ListItem"))
                                    }
                                    NavigationLink(destination: ToggleDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("Toggle"))
                                    }
                                    NavigationLink(destination: PaginationViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("Pagination"))
                                    }
                                    NavigationLink(destination: SegmentedPickerViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("SegmentedPicker"))
                                    }
                                }
                                Group {
                                    NavigationLink(destination: SliderDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("Slider"))
                                    }
                                    NavigationLink(destination: LoadingIndicatorDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("LoadingIndicator"))
                                    }
                                    NavigationLink(destination: ChipDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("Chip"))
                                    }
                                    NavigationLink(destination: MapMarkerDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                        SBBListItem(label: Text("MapMarker"), showBottomLine: false)
                                    }
                                }
                            }
                            SBBFormGroup(title: "Modules") {
                                NavigationLink(destination: BubbleViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("BubbleView"))
                                }
                                NavigationLink(destination: InfoViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("InfoView"))
                                }
                                NavigationLink(destination: InfoViewCollapsibleDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("InfoViewCollapsible"))
                                }
                                NavigationLink(destination: FormGroupView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("FormGroup"))
                                }
                                NavigationLink(destination: ModalViewDemo(colorScheme: self.$colorScheme, contentSizeCategory: $contentSizeCategory).environment(\.sizeCategory, contentSizeCategory).environmentObject(modalViewModel)) {
                                    SBBListItem(label: Text("ModalView"))
                                }
                                NavigationLink(destination: DialogueDemo(colorScheme: self.$colorScheme, contentSizeCategory: $contentSizeCategory, model: DialogueViewModel()).environment(\.sizeCategory, contentSizeCategory).environmentObject(modalViewModel)) {
                                    SBBListItem(label: Text("Dialogue"))
                                }
                                NavigationLink(destination: ToastDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory).environmentObject(SBBToastService())) {
                                    SBBListItem(label: Text("Toast"))
                                }
                                NavigationLink(destination: ProcessFlowDemo(viewModel: ProcessFlowViewModel(), colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("ProcessFlow"), showBottomLine: false)
                                }
                            }
                            SBBFormGroup(title: "PageTypes") {
                                NavigationLink(destination: OnboardingViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("OnboardingView"), showBottomLine: false)
                                }
                            }
                            SBBFormGroup(title: "ViewModifiers") {
                                NavigationLink(destination: NavigationBarWithSBBIconDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("NavigationBar with SBB Icon"))
                                }
                                NavigationLink(destination: BannerDemo(colorScheme: self.$colorScheme).environmentObject(bannerViewModel).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Banner"), showBottomLine: false)
                                }
                            }
                            SBBFormGroup(title: "Additional Information") {
                                Button(action: {
                                    guard let url = URL(string: "https://digital.sbb.ch/de/design-system-mobile-new"),
                                        UIApplication.shared.canOpenURL(url) else {
                                        return
                                    }
                                    UIApplication.shared.open(url)
                                }) {
                                    SBBListItem(label: Text("Official Documentation"), image: Image(sbbName: "circle-information", size: .small))
                                }
                                Button(action: {
                                    guard let url = URL(string: "https://sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx"),
                                        UIApplication.shared.canOpenURL(url) else {
                                        return
                                    }
                                    UIApplication.shared.open(url)
                                }) {
                                    SBBListItem(label: Text("Mobile Libraries"), image: Image(sbbName: "smartphone", size: .small), showBottomLine: false)
                                }
                            }
                        }
                            .padding(16)
                    }
                        .navigationBarTitle("SBB DSM SwiftUI", displayMode: .inline)
                        .sbbStyle()
                        .colorScheme(colorScheme)
                        .environment(\.sizeCategory, contentSizeCategory)
                }
                    .navigationViewStyle(StackNavigationViewStyle())    // https://stackoverflow.com/questions/57905499/swiftui-code-is-working-in-iphone-but-blank-screen-in-ipad
                    .sbbEnvironmentBanner(bannerViewModel.none ? nil : ( bannerViewModel.dev ? .dev : ( bannerViewModel.test ? .test : ( bannerViewModel.int ? .int : .poc))))
                    .sbbModalContainer()
            } else {
                OnboardingView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(colorScheme: .light)
                .previewDisplayName("Onboarding")
                .environmentObject(OnboardingViewModel(onboardingState: .startView))
            ContentView(colorScheme: .light)
                .previewDisplayName("Light")
            ContentView(colorScheme: .dark)
                .previewDisplayName("Dark")
        }
            .environmentObject(BannerViewModel())
            .environmentObject(SBBModalViewModel())
            .environmentObject(OnboardingViewModel(onboardingState: .hidden))
    }
}
