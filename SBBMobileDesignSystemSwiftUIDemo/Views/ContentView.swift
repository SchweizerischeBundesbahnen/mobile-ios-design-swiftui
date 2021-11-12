//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ContentView: View {
    
    @State var colorScheme: ColorScheme = .light
    @State var contentSizeCategory: ContentSizeCategory = .medium
    @State var theme: Theme = .sbbDefault
    @State var selectedBanner: SBBEnvironmentBanner = .none
    @State private var navigationViewID = UUID()    // can be used to reload the View
    @State private var navigationViewContentID = UUID() // can be used to reload the View
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        SBBInfoView(image: Image(sbbName: "smartphone", size: .medium), text: Text("This demo app showcases all features of the Design System Mobile (DSM) SwiftUI Library."))
                        SBBSegmentedPicker(selection: $theme, tags: Theme.allCases) {
                            Text("Red")
                                .foregroundColor(Theme.sbbDefault.sbbTheme.primaryColor)
                            Text("Blue")
                                .foregroundColor(Theme.night.sbbTheme.primaryColor)
                        }
                            .onChange(of: theme) { newTheme in
                                SBBAppearance.setupSBBAppearance(theme: newTheme.sbbTheme)
                                self.navigationViewID = UUID() // trigger a reload of the NavigationView
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    self.navigationViewContentID = UUID() // SwiftUI bug: .navigationBarTitleDisplayMode(.inline) is ignored when only reloading the NavigationView, so we also need to reload it's content in a 2nd step.
                                }
                            }
                        SBBSegmentedPicker(selection: $colorScheme, tags: [.light, .dark]) {
                            Text("Light")
                            Text("Dark")
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
                                NavigationLink(destination: RadioButtonView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
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
                            NavigationLink(destination: ModalViewDemo(colorScheme: self.$colorScheme, contentSizeCategory: $contentSizeCategory).environment(\.sizeCategory, contentSizeCategory)) {
                                SBBListItem(label: Text("ModalView"))
                            }
                            NavigationLink(destination: DialogueDemo(colorScheme: self.$colorScheme, contentSizeCategory: $contentSizeCategory).environment(\.sizeCategory, contentSizeCategory)) {
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
                            NavigationLink(destination: BannerDemo(colorScheme: self.$colorScheme, selectedBanner: $selectedBanner).environment(\.sizeCategory, contentSizeCategory)) {
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
                                SBBListItem(label: Text("Official Documentation"), image: Image(sbbName: "document-text", size: .small))
                            }
                            Button(action: {
                                guard let url = URL(string: "https://sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx"),
                                    UIApplication.shared.canOpenURL(url) else {
                                    return
                                }
                                UIApplication.shared.open(url)
                            }) {
                                SBBListItem(label: Text("Mobile Libraries"), image: Image(sbbName: "smartphone", size: .small))
                            }
                            Button(action: {
                                onboardingViewModel.currentOnboardingCardIndex = 0
                                onboardingViewModel.onboardingState = .startView
                            }) {
                                SBBListItem(label: Text("Show Onboarding"), image: Image(sbbName: "circle-information", size: .small), showBottomLine: false)
                            }
                        }
                    }
                        .sbbScreenPadding()
                }
                    .id(navigationViewContentID)
                    .navigationBarTitle("SBB DSM SwiftUI")
                    .navigationBarTitleDisplayMode(.inline)
                    .sbbStyle()
                    .colorScheme(colorScheme)
                    .environment(\.sizeCategory, contentSizeCategory)
            }
                .id(navigationViewID)
                .navigationViewStyle(StackNavigationViewStyle())    // https://stackoverflow.com/questions/57905499/swiftui-code-is-working-in-iphone-but-blank-screen-in-ipad
                .sbbEnvironmentBanner(selectedBanner)
            if onboardingViewModel.onboardingState != .hidden {
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
            .environmentObject(OnboardingViewModel(onboardingState: .hidden))
    }
}
