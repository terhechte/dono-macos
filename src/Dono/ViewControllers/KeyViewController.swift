// Dono OS X - Password Derivation Tool
// Copyright (C) 2016  Dono - Password Derivation Tool
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
