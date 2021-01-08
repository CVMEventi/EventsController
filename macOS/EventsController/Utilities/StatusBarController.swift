//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import AppKit

class StatusBarController {
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    private let menu = NSMenu()
    
    init(_ popover: NSPopover) {
        self.popover = popover
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = #imageLiteral(resourceName: "MenuBarIcon")
            statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarButton.image?.isTemplate = true
            
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
            statusBarButton.sendAction(on: [.rightMouseUp, .leftMouseUp])
        }
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            menu.addItem(withTitle: "Version: \(version)", action: nil, keyEquivalent: "")
        }
        
        menu.addItem(NSMenuItem(title: "Exit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
        
        popover.behavior = .transient
    }
    
    @objc func togglePopover(sender: AnyObject) {
        guard let event = NSApp.currentEvent else { return }
        switch event.type {
        case .rightMouseUp:
            statusItem.menu = menu
            statusItem.button?.performClick(nil)
            statusItem.menu = nil
        default:
            if(popover.isShown) {
                hidePopover(sender)
            }
            else {
                showPopover(sender)
            }
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func showMenu(_ sender: AnyObject) {
        
    }
    
    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
    }
    
    func mouseEventHandler(_ event: NSEvent?) {
        if(popover.isShown) {
            hidePopover(event!)
        }
    }
}
