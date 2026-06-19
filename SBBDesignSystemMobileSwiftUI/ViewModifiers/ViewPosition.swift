//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//
import SwiftUI


public extension View {
    
    /**
     Allows to get the frame of a view.
     
     - Parameters:
        - _: A binding to CGRect in which to store the value (frame) of the view.
     */
    func viewPosition(_ contentRect: Binding<CGRect>, in coordinateSpace: CoordinateSpace) -> some View {
        self.modifier(ViewPosition(contentRect: contentRect, contentFloat: .constant(.zero), positionType: .position, coordinateSpace: coordinateSpace))
    }
    
    func viewMinY(_ contentSize: Binding<CGFloat>, in coordinateSpace: CoordinateSpace) -> some View {
        self.modifier(ViewPosition(contentRect: .constant(.zero), contentFloat: contentSize, positionType: .minY, coordinateSpace: coordinateSpace))
    }
}


struct ViewPosition: ViewModifier {
    enum PositionType {
        case position
        case minY
    }
    
    @Binding var contentRect: CGRect
    @Binding var contentFloat: CGFloat
    var positionType: PositionType
    let coordinateSpace: CoordinateSpace
    
    init(contentRect: Binding<CGRect>, contentFloat: Binding<CGFloat>, positionType: PositionType, coordinateSpace: CoordinateSpace) {
        self._contentRect = contentRect
        self._contentFloat = contentFloat
        self.positionType = positionType
        self.coordinateSpace = coordinateSpace
    }
        
    func body(content: Content) -> some View {
        content
            .background(ViewPositionGeometry(coordinateSpace: coordinateSpace))
            .onPreferenceChange(ViewPositionKey.self, perform: { value in
                switch positionType {
                case .position:
                    self.contentRect = value.first?.rect ?? .zero
                case .minY:
                    self.contentFloat = value.first?.rect.minY ?? .zero
                }
                
            })
    }
}
