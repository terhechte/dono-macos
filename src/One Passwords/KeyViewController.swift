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
    @IBOutlet weak var keySecureTextField: NSSecureTextField!
    
    var eventMonitor = AnyObject?()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.keySecureTextField.stringValue = self.key.getKey()
        
        self.registerKeyShortcuts()
    }
    
    override func viewWillDisappear()
    {
        NSEvent.removeMonitor(self.eventMonitor!)
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

    @IBAction func done(sender: AnyObject)
    {
        let newKey = self.keySecureTextField.stringValue
     
        if (newKey.isEmpty)
        {
            return
        }
        
        if (!newKey.isEmpty && newKey.characters.count >= Dono.MIN_KEY_LENGTH)
        {
            self.key.setkey(newKey);
            
            self.close(sender)
        }
        else
        {
            self.keySecureTextField.stringValue = self.key.getKey()

            self.showCrititcalAlert(
                "Your Key is not long enough!",
                message: "Your Key has to be longer than " + String(Dono.MIN_KEY_LENGTH - 1) + " characters")
        }
    }

    @IBAction func close(sender: AnyObject)
    {
        self.dismissController(sender)
    }
    
    private func registerKeyShortcuts()
    {
        self.eventMonitor = NSEvent.addLocalMonitorForEventsMatchingMask(.KeyDownMask) { (aEvent) -> NSEvent? in
            
            if (aEvent.keyCode == DonoViewController.EscKeyCode)
            {
                self.close(self)
            }
            else if (aEvent.keyCode == DonoViewController.EnterKeyCode)
            {
                self.done(self)
            }
            
            return aEvent
        }
    }
}
