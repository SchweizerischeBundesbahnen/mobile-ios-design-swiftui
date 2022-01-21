# SBBDesignSystemMobileSwiftUI Tests

SBB DSM uses Snapshot Tests to compare the current simulator/device UI to reference snapshots.

## Recording new Snapshots

* Write the needed UnitTests
* Overwrite the following value in 'SBBSnapshotTest' to true
 ```swift
     // set to true to enable reference screenshot recording instead of snapshot comparison (make sure to set your simulator in .light appearance!)
    var recordNewReferenceSnapshots: Bool {
        return false
    }
 ```
 * Make sure to add the newly recorded screenshot files (.png) to the target of SBBDesignSystemMobileSwiftUITest
 * Reset the recordNewReferenceSnapshots value to false
 * Run tests
