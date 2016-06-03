//
//  NewLabelViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/14/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Cocoa
import SwiftHEXColors

class AddLabelViewController: DonoViewController
{
    var labels = PersistableLabels()
    var labelsViewController = LabelsViewController()
    
    @IBOutlet weak var newLabelTextField: NSTextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.labels.getAll()

        self.registerKeyShortcuts()
    }
    
    @IBAction func close(sender: AnyObject)
    {
        self.dismissController(self)
    }
    
    @IBAction func addLabel(sender: AnyObject)
    {
        var label = self.newLabelTextField.stringValue
        
        label = self.labels.add(label)
        
        if (label.isEmpty)
        {
            let canonicalLabel = self.labels.canonical(self.newLabelTextField.stringValue)
            
            if (!canonicalLabel.isEmpty)
            {
                self.showCrititcalAlert(
                    "Label already exists!",
                    message: "Label " + canonicalLabel + " is already added to your Labels")
                
                self.newLabelTextField.stringValue = String()
            }
        }
        else
        {
            self.dismissController(self)
            self.labelsViewController.refreshLabels()
        }
    }
    
    private func registerKeyShortcuts()
    {
        NSEvent.addLocalMonitorForEventsMatchingMask(.KeyDownMask) { (aEvent) -> NSEvent? in
            
            if (aEvent.keyCode == DonoViewController.EscKeyCode)
            {
                self.close(self)
            }
            else if (aEvent.keyCode == DonoViewController.EnterKeyCode)
            {
                self.addLabel(self)
            }
            
            return aEvent
        }
    }
}
