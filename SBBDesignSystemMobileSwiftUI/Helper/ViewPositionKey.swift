//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  

import SwiftUI

struct ViewPositionKey: PreferenceKey {
    public static var defaultValue: [ViewPositionData] = []
    
    static func reduce(value: inout [ViewPositionData], nextValue: () -> [ViewPositionData]) {
            value.append(contentsOf: nextValue())
        }
    
    typealias Value = [ViewPositionData]
}

struct ViewPositionGeometry: View {
    let coordinateSpace: CoordinateSpace
    
    public var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewPositionKey.self, value: [ViewPositionData(rect: geometry.frame(in: coordinateSpace))])
        }
    }
}

// WORKAROUND: ViewSizeData instead of simple CGSize, workaround as regular PreferenceSize method does not work here https://developer.apple.com/forums/thread/689944
struct ViewPositionData: Identifiable, Equatable, Hashable {
    let id: UUID = UUID()
    let rect: CGRect

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

