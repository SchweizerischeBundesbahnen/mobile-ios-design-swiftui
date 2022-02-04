//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import Foundation
import SnapshotTesting
import XCTest

public func assertSnapshot<Value, Format>(
    matching value: @autoclosure () throws -> Value,
    as snapshotting: Snapshotting<Value, Format>,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let snapshotDirectory = Bundle(for: SBBStyleTests.self).infoDictionary!["SnapshotTestingReferenceDir"] as! String

    let fileUrl = URL(fileURLWithPath: "\(file)", isDirectory: false)
    let fileName = fileUrl.deletingPathExtension().lastPathComponent
    let groupName = fileUrl.deletingLastPathComponent().lastPathComponent
    let snapshotDirectoryUrl = URL(fileURLWithPath: "\(snapshotDirectory)/\(groupName)/\(fileName)", isDirectory: true)

    let failure = verifySnapshot(
        matching: try value(),
        as: snapshotting,
        named: name,
        record: recording,
        snapshotDirectory: snapshotDirectoryUrl.path,
        timeout: timeout,
        file: file,
        testName: testName
    )
    guard let message = failure else { return }
    XCTFail("\(message) snap: \(snapshotDirectoryUrl)", file: file, line: line)
}
