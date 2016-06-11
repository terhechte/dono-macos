//
//  DonoViewController.swift
//  Dono
//
//  Created by Ghost on 6/2/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import AppKit
import Cocoa

class DonoViewController : NSViewController
{
    static var DarkPrimaryColor = "#1976d2"

    static var PrimaryColor = "#2196f3"

    static var SecondaryText = "#E3E3E3"
    
    static var EscKeyCode = UInt16(53)
    
    static var EnterKeyCode = UInt16(36)
    
    let key = PersistableKey()

    let labels = PersistableLabels()
    
    var settings = Settings()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    internal func showInfoAlert(title: String, message: String, buttonTitle: String)
    {
        self.showAlert(title, message: message, buttonTitle: buttonTitle, style: NSAlertStyle.InformationalAlertStyle)
    }

    internal func showCrititcalAlert(title: String, message: String)
    {
        self.showAlert(title, message: message, buttonTitle: "Got it!", style: NSAlertStyle.CriticalAlertStyle)
    }
    
    internal func copyToPasteboard(text: String)
    {
        let pasteboard = NSPasteboard.generalPasteboard()
        pasteboard.clearContents()
        pasteboard.setString(text, forType: NSPasteboardTypeString)
    }

    private func showAlert(title: String, message: String, buttonTitle: String, style: NSAlertStyle)
    {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.addButtonWithTitle(buttonTitle)
        alert.alertStyle = style
        alert.beginSheetModalForWindow(NSApplication.sharedApplication().mainWindow!, completionHandler: nil)
    }

    private func setupView()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(hexString: DonoViewController.PrimaryColor)?.colorWithAlphaComponent(1).CGColor
    }
}