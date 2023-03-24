//
//  Copyright © 2023 SBB. All rights reserved.
//

import Foundation

struct SBBIconsHelper {
    
    static let shared = SBBIconsHelper()
    
    let iconsIndex: SBBIconIndex?
    
    private init() {
        
        if let fileUrl = SBBBundle.getBundle().url(forResource: "SBBIconsIndex", withExtension: "json"), let sbbData = try? Data(contentsOf: fileUrl) {
            iconsIndex = try? JSONDecoder().decode(SBBIconIndex.self, from: sbbData)
        } else {
            iconsIndex = nil
        }
    }
    
    func hasColor(iconName: String) -> Bool {
        if let sbbIconMetadata = iconsIndex?.icons.first(where: {$0.name == iconName}) {
            return sbbIconMetadata.color
        }
        return false
    }
    
}

struct SBBIconMetadata: Decodable {
    let name: String
    let color: Bool
    let scalable: Bool
    let tags: [String]
}

struct SBBIconIndex: Decodable {
    let version: String
    let icons: [SBBIconMetadata]
}
