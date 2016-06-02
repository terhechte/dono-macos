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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set view's background color
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(hexString: "#2196f3")?.colorWithAlphaComponent(1).CGColor
    }
    
    func showInfoAlert(title: String, message: String, buttonTitle: String)
    {
        self.showAlert(title, message: message, buttonTitle: buttonTitle, style: NSAlertStyle.InformationalAlertStyle)
    }

    func showCrititcalAlert(title: String, message: String, buttonTitle: String)
    {
        self.showAlert(title, message: message, buttonTitle: buttonTitle, style: NSAlertStyle.CriticalAlertStyle)
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