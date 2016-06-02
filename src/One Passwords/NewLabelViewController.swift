//
//  NewLabelViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/14/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Cocoa
import SwiftHEXColors

class NewLabelViewController: DonoViewController
{
    var labels = PersistableLabels()
    var labelsViewController = LabelsViewController()
    
    @IBOutlet weak var newLabelTextField: NSTextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.labels.getAll()
    }
    
    @IBAction func dismiss(sender: AnyObject)
    {
        self.dismissController(self)
    }
    
    @IBAction func addLabel(sender: AnyObject)
    {
        self.labels.add(self.newLabelTextField.stringValue)
        self.dismissController(self)
        self.labelsViewController.refreshLabels()
    }
}
