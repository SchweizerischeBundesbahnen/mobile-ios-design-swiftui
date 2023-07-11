//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//
import SwiftUI


public extension View {
    
    /**
     Allows to get the size of a view.
     
     ## Overview
     Typically used to know whether to use a ScrollView (if the content does not fit in th screen).
     ```swift
     
        @State var contentSize: CGSize = .zero
     
        private var contentView: some View {
            YourView()
                .viewSize(contentSize: $contentSize)
        }
     
        var body: some View {
            GeometryReader { geometry in
                 VStack {
                     if useScrollView(parentSize: geometry.size.height) {
                         ScrollView(.vertical, showsIndicators: false) {
                             contentView
                         }
                     } else {
                        contentView
                     }
                 }
             }
        }
     }
     ```
     
     - Parameters:
        - _: A binding to CGSize in which to store the value (size) of the view.
     */
    func viewSize(_ contentSize: Binding<CGSize>) -> some View {
        self.modifier(ViewSize(contentSize: contentSize, contentFloat: .constant(0), sizeType: .size))
    }
    
    func viewHeight(_ contentFloat: Binding<CGFloat>) -> some View {
        self.modifier(ViewSize(contentSize: .constant(.zero), contentFloat: contentFloat, sizeType: .height))
    }
    
    func viewWidth(_ contentFloat: Binding<CGFloat>) -> some View {
        self.modifier(ViewSize(contentSize: .constant(.zero), contentFloat: contentFloat, sizeType: .width))
    }
    
}


struct ViewSize: ViewModifier {
    enum SizeType {
        case size
        case height
        case width
    }
    
    @Binding var contentSize: CGSize
    @Binding var contentFloat: CGFloat
    var sizeType: SizeType
    
    init(contentSize: Binding<CGSize>, contentFloat: Binding<CGFloat>, sizeType: SizeType) {
        self._contentSize = contentSize
        self._contentFloat = contentFloat
        self.sizeType = sizeType
    }
        
    func body(content: Content) -> some View {
        content
            .background(ViewGeometry())
            .onPreferenceChange(ViewSizeKey.self, perform: { value in
                switch sizeType {
                case .size:
                    self.contentSize = value.first?.size ?? .zero
                case .height:
                    self.contentFloat = value.first?.size.height ?? 0.0
                case .width:
                    self.contentFloat = value.first?.size.width ?? 0.0
                }
                
            })
    }
}
