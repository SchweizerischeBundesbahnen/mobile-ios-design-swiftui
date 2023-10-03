//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct NotificationDemo: View {
    @Binding var colorScheme: ColorScheme
    
    @State var isPresented1: Bool = true
    @State var isPresented2: Bool = true
    @State var isPresented3: Bool = true
    @State var showMoreInfo: Bool = false
    @State var selectedStatus: StatusType = .alert
    
    @State var enableCloseAfterSeconds: Bool = false
    @State var closeAfterSeconds: Int = 3
    
    @State var enableMaxNumberLines: Bool = false
    @State var maxNumberLines: Int = 3
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SBBFormGroup {
                    SBBSegmentedPicker(selection: $selectedStatus, tags: [StatusType.alert, .warning, .success, .info]) {
                        Text("Alert")
                            .tag(StatusType.alert)
                        Text("Warning")
                            .tag(StatusType.warning)
                        Text("Success")
                            .tag(StatusType.success)
                        Text("Info")
                            .tag(StatusType.info)
                    }
                    SBBCheckBox(isOn: $enableMaxNumberLines, text: Text("Set a maximum number of lines"))
                    if enableMaxNumberLines {
                        SBBUpDnCounterView(label: Text("Max number of lines"), value: $maxNumberLines)
                    }
                    SBBCheckBox(isOn: $enableCloseAfterSeconds, text: Text("Close the notification after a while"), showBottomLine: enableCloseAfterSeconds)
                    if enableCloseAfterSeconds {
                        SBBUpDnCounterView(label: Text("Close after x seconds"), value: $closeAfterSeconds, showBottomLine: false)
                    }
                }
            
                Text("With title and text")
                if enableCloseAfterSeconds {
                    SBBNotification(isPresented: $isPresented1, statusType: selectedStatus, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), maxNumberLines: enableMaxNumberLines ? maxNumberLines : nil, closeAfterSeconds: closeAfterSeconds)
                } else {
                    SBBNotification(isPresented: $isPresented1, statusType: selectedStatus, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), maxNumberLines: enableMaxNumberLines ? maxNumberLines : nil, closeAfterSeconds: nil)
                }
                
                if !isPresented1 {
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresented1 = true
                        }) {
                            Text("Show Notification")
                        }
                        .buttonStyle(SBBTertiaryButtonStyle())
                        Spacer()
                    }
                }
                
                Text("Without title")
                if enableCloseAfterSeconds {
                    SBBNotification(isPresented: $isPresented2, statusType: selectedStatus, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), maxNumberLines: enableMaxNumberLines ? maxNumberLines : nil, closeAfterSeconds: closeAfterSeconds)
                } else {
                    SBBNotification(isPresented: $isPresented2, statusType: selectedStatus, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), maxNumberLines: enableMaxNumberLines ? maxNumberLines : nil, closeAfterSeconds: nil)
                }
                if !isPresented2 {
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresented2 = true
                        }) {
                            Text("Show Notification")
                        }
                        .buttonStyle(SBBTertiaryButtonStyle())
                        Spacer()
                    }
                }
                
                Text("With more info")
                if enableCloseAfterSeconds {
                    SBBNotification(isPresented: $isPresented3, statusType: selectedStatus, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), maxNumberLines: enableMaxNumberLines ? maxNumberLines : nil, closeAfterSeconds: closeAfterSeconds, onMoreInfo: {
                        self.showMoreInfo = true
                    })
                } else {
                    SBBNotification(isPresented: $isPresented3, statusType: selectedStatus, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), maxNumberLines: enableMaxNumberLines ? maxNumberLines : nil, closeAfterSeconds: nil, onMoreInfo: {
                        self.showMoreInfo = true
                    })
                }
                if !isPresented3 {
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresented3 = true
                        }) {
                            Text("Show Notification")
                        }
                        .buttonStyle(SBBTertiaryButtonStyle())
                        Spacer()
                    }
                }
                                    
            }
            .sbbScreenPadding()
        }
        .sbbModal(isPresented: $showMoreInfo) {
            SBBModalView(title: Text("More info"), style: .bottom, isPresented: $showMoreInfo) {
                VStack {
                    Spacer()
                    Text("Some more infos")
                    Spacer()
                }
            }
        }
        .navigationBarTitle("Notification")
        .sbbStyle()
        .colorScheme(colorScheme)
    }
}


struct NotificationDemo_Previews: PreviewProvider {
    static var previews: some View {
        NotificationDemo(colorScheme: .constant(.light))
        NotificationDemo(colorScheme: .constant(.dark))
    }
}
