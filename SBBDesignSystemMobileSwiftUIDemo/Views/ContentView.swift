//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct ContentView: View {
    
    @State var colorScheme: ColorScheme = .light
    @State var contentSizeCategory: ContentSizeCategory = .medium
    @State var theme: Theme = .sbbDefault
    @State var selectedBanner: SBBEnvironmentBanner = .none
    @State private var navigationViewID = UUID()    // can be used to reload the View
    #if targetEnvironment(simulator)
    @State private var navigationViewContentID = UUID() // can be used to reload the View
    #endif
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        SBBInfoView(image: Image(sbbIcon: .smartphone_medium), text: Text("This demo app showcases all features of the Design System Mobile (DSM) SwiftUI Library."))
                        SBBSegmentedPicker(selection: $theme, tags: Theme.allCases) {
                            Text("Red")
                                .foregroundColor(Theme.sbbDefault.sbbTheme.primaryColor)
                            Text("Blue")
                                .foregroundColor(Theme.night.sbbTheme.primaryColor)
                        }
                            .onChange(of: theme) { newTheme in
                                SBBAppearance.setupSBBAppearance(theme: newTheme.sbbTheme)
                                self.navigationViewID = UUID() // trigger a reload of the NavigationView
                                #if targetEnvironment(simulator)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                        self.navigationViewContentID = UUID() // SwiftUI bug: .navigationBarTitleDisplayMode(.inline) is ignored when only reloading the NavigationView, so we also need to reload it's content in a 2nd step.
                                    }
                                #endif
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
                        SBBFormGroup(title: "Components") {
                            Group {
                                NavigationLink(destination: AccordionDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Accordion"))
                                }
                                NavigationLink(destination: BannerDemo(colorScheme: self.$colorScheme, selectedBanner: $selectedBanner).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Banner"))
                                }
                                NavigationLink(destination: BubbleViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("BubbleView"))
                                }
                                NavigationLink(destination: ButtonDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Button"))
                                }
                                NavigationLink(destination: CheckBoxView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("CheckBox"))
                                }
                                NavigationLink(destination: ChipDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Chip"))
                                }
                            }
                            Group {
                                NavigationLink(destination: DialogueDemo(colorScheme: self.$colorScheme, contentSizeCategory: $contentSizeCategory).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Dialogue"))
                                }
                                NavigationLink(destination: DividerViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Divider"))
                                }
                                NavigationLink(destination: FormGroupView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("FormGroup"))
                                }
                                NavigationLink(destination: HeaderDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Header"))
                                }
                                NavigationLink(destination: InfoViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("InfoView"))
                                }
                                NavigationLink(destination: ListItemDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("ListItem"))
                                }
                                NavigationLink(destination: LoadingIndicatorDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("LoadingIndicator"))
                                }
                            }
                            Group {
                                NavigationLink(destination: MapMarkerDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("MapMarker"))
                                }
                                NavigationLink(destination: MessageDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Message"))
                                }
                                NavigationLink(destination: ModalViewDemo(colorScheme: self.$colorScheme, contentSizeCategory: $contentSizeCategory).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("ModalView"))
                                }
                                NavigationLink(destination: NavigationBarWithSBBIconDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("NavigationBar with SBB Icon"))
                                }
                                NavigationLink(destination: NotificationDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Notification"))
                                }
                                NavigationLink(destination: OnboardingViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("OnboardingView"))
                                }
                                NavigationLink(destination: PaginationViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Pagination"))
                                }
                                NavigationLink(destination: PickerDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Picker"))
                                }
                                NavigationLink(destination: ProcessFlowDemo(viewModel: ProcessFlowViewModel(), colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("ProcessFlow"))
                                }
                                NavigationLink(destination: PromotionBoxDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("PromotionBox"))
                                }
                            }
                            Group {
                                NavigationLink(destination: RadioButtonView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("RadioButton"))
                                }
                                NavigationLink(destination: SegmentedPickerViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("SegmentedPicker"))
                                }
                                NavigationLink(destination: SliderDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Slider"))
                                }
                                NavigationLink(destination: StatusDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Status"))
                                }
                                NavigationLink(destination: ToggleDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("Switch / Toggle"))
                                }
                                NavigationLink(destination: TextAreaView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("TextArea"))
                                }
                                NavigationLink(destination: TextFieldView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory).environmentObject(TextFieldViewModel())) {
                                    SBBListItem(label: Text("TextField"))
                                }
                                NavigationLink(destination: ToastDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory).environmentObject(SBBToastService())) {
                                    SBBListItem(label: Text("Toast"))
                                }
                                NavigationLink(destination: TabViewDemo(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("TabBar"))
                                }
                                NavigationLink(destination: UpDnCounterDemoView(colorScheme: self.$colorScheme).environment(\.sizeCategory, contentSizeCategory)) {
                                    SBBListItem(label: Text("UpDnCounter"), showBottomLine: false)
                                }
                            }
                        }
                        SBBFormGroup(title: "Additional Information") {
                            Button(action: {
                                guard let url = URL(string: "https://digital.sbb.ch/de/design-system/mobile/overview/"),
                                    UIApplication.shared.canOpenURL(url) else {
                                    return
                                }
                                UIApplication.shared.open(url)
                            }) {
                                SBBListItem(label: Text("Official Documentation"), leftImage: Image(sbbIcon: .document_text_small))
                            }
                            Button(action: {
                                guard let url = URL(string: "https://sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx"),
                                    UIApplication.shared.canOpenURL(url) else {
                                    return
                                }
                                UIApplication.shared.open(url)
                            }) {
                                SBBListItem(label: Text("Mobile Libraries"), leftImage: Image(sbbIcon: .smartphone_small))
                            }
                            Button(action: {
                                onboardingViewModel.currentOnboardingCardIndex = 0
                                onboardingViewModel.onboardingState = .startView
                            }) {
                                SBBListItem(label: Text("Show Onboarding"), leftImage: Image(sbbIcon: .circle_information_small), showBottomLine: false)
                            }
                        }
                    }
                        .sbbScreenPadding()
                }
                    #if targetEnvironment(simulator)
                    .id(navigationViewContentID)
                    #endif
                    .navigationBarTitle("SBB DSM SwiftUI")
                    .navigationBarTitleDisplayMode(.inline)
                    .sbbStyle()
                    .colorScheme(colorScheme)
                    .environment(\.sizeCategory, contentSizeCategory)
            }
                .id(navigationViewID)
                .navigationViewStyle(StackNavigationViewStyle())    // iPad SwiftUI SplitView issue workaround
                .sbbEnvironmentBanner(selectedBanner)
                .accentColor(.white)
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
