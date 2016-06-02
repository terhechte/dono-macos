//
//  KeyViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/14/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Cocoa
import DonoCore

class KeyViewController : DonoViewController
{
    let key = PersistableKey()
    
    @IBOutlet weak var keySecureTextField: NSSecureTextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupView()
        
        self.keySecureTextField.stringValue = self.key.getKey()
    }
    
    @IBAction func done(sender: AnyObject)
    {
        let newKey = self.keySecureTextField.stringValue
        
        if (!newKey.isEmpty && newKey.characters.count >= Dono.MIN_KEY_LENGTH)
        {
            self.key.setkey(newKey);
            self.dismissController(self);
        }
        else
        {
            let alert = NSAlert()
            alert.messageText = "Your Key is not long enough!"
            alert.informativeText = "Your Key has to be longer than " + String(Dono.MIN_KEY_LENGTH - 1) + " characters"
            alert.addButtonWithTitle("Got it!")
            alert.alertStyle = NSAlertStyle.CriticalAlertStyle
            alert.beginSheetModalForWindow(self.view.window!, completionHandler: nil)
            
            self.keySecureTextField.stringValue = self.key.getKey()
        }
    }
    
    private func setupView()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(hexString: "#2196f3")?.CGColor
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "ShowPlainKeyView")
        {
            if let destinationVC = segue.destinationController as? PlainKeyViewController
            {
                destinationVC.plainKey = self.keySecureTextField.stringValue
            }
        }
    }
}
