//
//  PlainKeyViewController.swift
//  Dono
//
//  Created by Ghost on 6/2/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Cocoa
import Foundation

class PlainKeyViewController : NSViewController
{
    var plainKey = String()
    
    @IBOutlet weak var plainKeyTextField: NSTextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.plainKeyTextField.stringValue = self.plainKey
    }
}