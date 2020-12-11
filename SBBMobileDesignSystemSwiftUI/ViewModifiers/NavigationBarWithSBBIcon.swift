//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public extension View {
    func navigationBarWithSBBIcon(onTouchAction: (() -> ())? = nil, bannerText: String? = nil, bannerTextColor: Color = Color.sbbColor(.black), bannerBackgroundColor: Color = Color.sbbColor(.lemon)) -> some View {
        self
            .navigationBarItems(trailing:
                Button(action: {
                    onTouchAction?()
                }) {
                    Image("sbb-logo-small", bundle: Helper.bundle)
                        .resizable()
                        .frame(width: 28, height: 14, alignment: .top)
                        .foregroundColor(.sbbColor(.textWhite))
                        .padding(.bottom, 7)
                }
                .accessibility(hidden: onTouchAction == nil)
                .disabled(onTouchAction == nil)
                .background(
                    Group {
                        if bannerText != nil {
                            Text(bannerText!)
                                .frame(width: 300, height: 18, alignment: .center)
                                .background(bannerBackgroundColor)
                                .rotationEffect(.init(degrees: 45))
                                .position(x: 44, y: 16)
                                .sbbFont(.legendSmall)
                                .foregroundColor(bannerTextColor)
                                .clipped()
                        }
                    }
                        .frame(width: 60, height: 44)
                        .accessibility(hidden: true)
                )
            )
    }
}
