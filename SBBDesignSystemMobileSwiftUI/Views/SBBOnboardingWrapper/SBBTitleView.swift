//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2025.
//

import SwiftUI

public struct SBBTitleView<ButtonView: View>: View {
        
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.sizeCategory) private var sizeCategory
    
    private let image: Image
    private let title: Text
    private let subtitle: Text?
    private let titleLineLimit: Int
    private let subtitleLineLimit: Int
    private let buttonView: ButtonView
    
    public init(image: Image, title: Text, subtitle: Text? = nil, titleLineLimit: Int = 3, subtitleLineLimit: Int = 5, @ViewBuilder buttonView: () -> ButtonView) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.titleLineLimit = titleLineLimit
        self.subtitleLineLimit = subtitleLineLimit
        self.buttonView = buttonView()
    }
    
    private var imageView: some View {
        image
            .resizable()
            .accessibility(hidden: true)
            .aspectRatio(contentMode: .fit)
    }
    
    private var titleView: some View {
        title
            .font(.sbbBold(size: 30))
            .foregroundColor(Color.sbbColor(.textBlack))
            .multiline(alignment: .center, lineLimit: self.horizontalSizeClass != .compact || self.verticalSizeClass != .regular && sizeCategory.isAccessibilityCategory ? 1 : titleLineLimit)
            .accessibility(addTraits: .isHeader)
    }
    
    @ViewBuilder
    private var subtitleView: some View {
        if let subtitle {
            subtitle
                .sbbFont(.medium_light)
                .foregroundColor(Color.sbbColor(.textBlack))
                .multiline(alignment: .center, lineLimit: subtitleLineLimit)
        }
    }
    
    private var portraitView: some View {
        VStack(spacing: sizeCategory.isAccessibilityCategory ? 0 : 32) {
            if !sizeCategory.isAccessibilityCategory {
                VStack {
                    Spacer()
                    imageView
                    Spacer()
                }
            }
            Spacer()
            
            VStack(spacing: 16) {
                titleView
                subtitleView
            }
            .foregroundColor(.sbbColor(.white))
            
            if sizeCategory.isAccessibilityCategory {
                Spacer()
            }
                        
            buttonView
        }
        .sbbScreenPadding(.horizontal)
        .sbbScreenPadding()
    }
    
    private var landscapeView: some View {
        GeometryReader { geometry in
            HStack(spacing: 16) {
                if !sizeCategory.isAccessibilityCategory {
                    VStack {
                        Spacer()
                        imageView
                        Spacer()
                    }
                    .frame(maxWidth: geometry.size.width / 2)
                    
                    Spacer()
                    VStack(alignment: .center, spacing: 32) {
                        Spacer()
                        VStack(alignment: .center, spacing: 16) {
                            titleView
                            subtitleView
                        }
                        buttonView
                        Spacer()
                    }
                    .frame(maxWidth: geometry.size.width / 2)
                } else {
                    VStack(spacing: 32) {
                        Spacer()
                        titleView
                        HStack(spacing: 32) {
                            subtitleView
                                .frame(maxWidth: geometry.size.width / 2)
                            Spacer()
                            buttonView
                                .frame(maxWidth: geometry.size.width / 2)
                        }
                        Spacer()
                    }
                    .sbbScreenPadding(.horizontal)
                }
            }
            .sbbScreenPadding()
            .frame(height: geometry.size.height)
        }
    }
    
    public var body: some View {
        Group {
            if self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular {
                portraitView
            } else {
                landscapeView
            }
        }
        .background(Color.sbbColor(.viewBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    SBBTitleView(image: Image("Onboarding_Luc", bundle: Helper.bundle), title: Text("Welcome!"), subtitle: Text("Welcome to your app tour."), buttonView: {
        Button(action: {}) {
            Text("Start")
        }.buttonStyle(SBBPrimaryButtonStyle())
    })
}
