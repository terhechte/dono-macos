//
//  DonoViewController.swift
//  Dono
//
//  Created by Ghost on 6/2/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Cocoa

class DonoViewController : NSViewController
{
    static var DarkPrimaryColor = "#1976d2"

    static var PrimaryColor = "#2196f3"

    static var AccentColor = "#03a9f4"

    static var SecondaryText = "#E3E3E3"
    
    static var EscKeyCode = UInt16(53)
    
    static var EnterKeyCode = UInt16(36)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set view's background color
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(hexString: DonoViewController.PrimaryColor)?.colorWithAlphaComponent(1).CGColor
    }
    
    func showInfoAlert(title: String, message: String, buttonTitle: String)
    {
        self.showAlert(title, message: message, buttonTitle: buttonTitle, style: NSAlertStyle.InformationalAlertStyle)
    }

    func showCrititcalAlert(title: String, message: String)
    {
        self.showAlert(title, message: message, buttonTitle: "Got it!", style: NSAlertStyle.CriticalAlertStyle)
    }

    func showAlert(title: String, message: String, buttonTitle: String, style: NSAlertStyle)
    {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.addButtonWithTitle(buttonTitle)
        alert.alertStyle = style
        alert.beginSheetModalForWindow(self.view.window!, completionHandler: nil)
    }
}