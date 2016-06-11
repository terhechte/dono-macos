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

class SettingsViewController : DonoViewController
{
    @IBOutlet weak var rememberKeyToggle: NSButton!
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.updateViewWithCurrentValues()
    }
    
    @IBAction func changedValue(sender: AnyObject)
    {
        let value = self.rememberKeyToggle.state == 1 ? true : false
        
        self.settings.setRememberKeyValue(value)
        
        let key = PersistableKey()

        if (value == false)
        {
            key.delete()
        }
        else
        {
            key.save()
        }
    }
    
    @IBAction func close(sender: AnyObject)
    {
        self.dismissController(nil)
    }
    
    private func updateViewWithCurrentValues()
    {
        let state = self.settings.getRememberKeyValue() == true ? 1 : 0
        
        self.rememberKeyToggle.state = state
    }
}
