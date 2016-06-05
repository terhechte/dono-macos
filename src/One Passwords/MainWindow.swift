//
//  MainWindow.swift
//  Dono
//
//  Created by Ghost on 6/2/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Cocoa

class MainWindow: NSWindowController
{
    override func windowDidLoad()
    {
        super.windowDidLoad()
        
        super.window?.backgroundColor = NSColor(hexString: DonoViewController.DarkPrimaryColor)
    }
    
    internal func showSettings()
    {
        (self.contentViewController as! LabelsViewController).performSegueWithIdentifier("ShowSettingsView", sender: self)
    }
}