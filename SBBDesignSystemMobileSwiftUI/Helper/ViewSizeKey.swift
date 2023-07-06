//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

struct ViewSizeKey: PreferenceKey {
    public static var defaultValue: [ViewSizeData] = []
    
    static func reduce(value: inout [ViewSizeData], nextValue: () -> [ViewSizeData]) {
            value.append(contentsOf: nextValue())
        }
    
    typealias Value = [ViewSizeData]
}

struct ViewGeometry: View {
    public var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: [ViewSizeData(size: geometry.size)])
        }
    }
}

// WORKAROUND: ViewSizeData instead of simple CGSize, workaround as regular PreferenceSize method does not work here https://developer.apple.com/forums/thread/689944
struct ViewSizeData: Identifiable, Equatable, Hashable {
    let id: UUID = UUID()
    let size: CGSize

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

