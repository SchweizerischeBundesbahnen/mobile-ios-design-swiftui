//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  

@preconcurrency import UIKit

final class OnOffSwitchLabelsSettings: ObservableObject {
    @Published var enabled: Bool = UIAccessibility.isOnOffSwitchLabelsEnabled
    private var observer: (any NSObjectProtocol)?

    init() {
        observer = NotificationCenter.default.addObserver(
            forName: UIAccessibility.onOffSwitchLabelsDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.enabled = UIAccessibility.isOnOffSwitchLabelsEnabled
            }
        }
    }

    deinit {
        if let obs = observer {
            NotificationCenter.default.removeObserver(obs)
        }
    }
}
