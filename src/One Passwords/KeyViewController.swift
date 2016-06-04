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
        
        self.registerKeyShortcuts()
        
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
            self.keySecureTextField.stringValue = self.key.getKey()

            self.showCrititcalAlert(
                "Your Key is not long enough!",
                message: "Your Key has to be longer than " + String(Dono.MIN_KEY_LENGTH - 1) + " characters")
        }
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
    
    private func registerKeyShortcuts()
    {
        NSEvent.addLocalMonitorForEventsMatchingMask(.KeyDownMask) { (aEvent) -> NSEvent? in
            
            if (aEvent.keyCode == DonoViewController.EscKeyCode)
            {
                self.done(self)
            }
            else if (aEvent.keyCode == DonoViewController.EnterKeyCode)
            {
                self.done(self)
            }
            
            return aEvent
        }
    }
}
