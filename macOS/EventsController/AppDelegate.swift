//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import Cocoa
import SwiftUI
import Swifter
import Defaults

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover = NSPopover.init()
    var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        ServerContainer.shared.addModules([
            WirecastModule.self
        ])
        ServerContainer.shared.start(port: Defaults[.port])
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = SettingsView()

        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.contentViewController = MainViewController()
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        //Initialising the status bar
        statusBar = StatusBarController(popover)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        ServerContainer.shared.stop()
    }


}

