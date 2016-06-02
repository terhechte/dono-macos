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
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(hexString: "#2196f3")?.CGColor
    }
}