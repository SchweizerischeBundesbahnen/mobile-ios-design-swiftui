#!/usr/bin/env swift

import Foundation

extension String {
    func startsWithNumber() -> Bool {
        self.first?.isNumber ?? false
    }
}

func main() {
    
    let cwd = FileManager.default.currentDirectoryPath
    print("script run from:\n" + cwd)
    let imagesPath = "\(cwd)/SBBDesignSystemMobileSwiftUI/Resources/Assets.xcassets/Images"
    print("Images are located in:\n" + imagesPath)
    let imagesUrl = URL(string: imagesPath)
    
    var images: [String] = []
    if let enumerator = FileManager.default.enumerator(at: imagesUrl!, includingPropertiesForKeys: [.isDirectoryKey, .nameKey]) {
        for case let fileURL as URL in enumerator {
            let fileAttributes = try! fileURL.resourceValues(forKeys:[.isDirectoryKey])
            if fileAttributes.isDirectory!, fileURL.lastPathComponent.hasSuffix(".imageset") {
                images.append(fileURL.lastPathComponent.replacingOccurrences(of: ".imageset", with: ""))
            }
        }
    }
    images.sort(by: {$0 < $1})
    
    let nameImages = images.map { img in
        var imgName = img
        if imgName.startsWithNumber() {
            imgName = "_\(imgName)"
        }
        return (imgName.replacingOccurrences(of: "-", with: "_").replacingOccurrences(of: "+", with: "_"), img)
    }
    
    // Generate the Swift enum file contents
    let enumContents =
    """
    //
    // Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
    //
    
    // ** generated automatically during a runscript while building SBBDesignSystemMobileSwiftUI
    
    public enum SBBIcon: String {
    \(nameImages.map { "    case \($0.0) = \"\($0.1)\"" }.joined(separator: "\n"))
    }
    """
    
    let outputFilePath = "\(cwd)/SBBDesignSystemMobileSwiftUI/Resources/SBBIconName.swift"
    
    // Write the contents to the output file
    try? enumContents.write(toFile: outputFilePath, atomically: true, encoding: .utf8)
    
    // Print a success message
    print("Swift enum file generated in: \(outputFilePath)")
}

main()
