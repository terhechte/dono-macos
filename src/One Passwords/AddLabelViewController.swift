// Dono OS X - Password Derivation Tool
// Copyright (C) 2016  Panos Sakkos
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
import SwiftHEXColors

class AddLabelViewController: DonoViewController
{
    @IBOutlet weak var newLabelTextField: NSTextField!
    
    var labelsViewController = LabelsViewController()
    
    var eventMonitor = AnyObject?()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.labels.getAll()
        
        self.registerKeyShortcuts()
    }
    
    override func viewWillDisappear()
    {
        NSEvent.removeMonitor(self.eventMonitor!)
    }

    @IBAction func close(sender: AnyObject)
    {
        self.dismissController(nil)
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
            self.close(sender)
            self.labelsViewController.refreshLabels()
        }
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
                self.addLabel(self)
            }
            
            return aEvent
        }
    }
}
