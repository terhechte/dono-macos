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

import AppKit
import Cocoa

class DonoViewController : NSViewController
{
    static var DarkPrimaryColor = "#1976d2"

    static var PrimaryColor = "#2196f3"

    static var SecondaryText = "#E3E3E3"
    
    static var EscKeyCode = UInt16(53)
    
    static var EnterKeyCode = UInt16(36)
    
    let key = PersistableKey()

    let labels = PersistableLabels()
    
    var settings = Settings()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    internal func showInfoAlert(_ title: String, message: String, buttonTitle: String)
    {
        self.showAlert(title, message: message, buttonTitle: buttonTitle, style: NSAlertStyle.informational)
    }

    internal func showCrititcalAlert(_ title: String, message: String)
    {
        self.showAlert(title, message: message, buttonTitle: "Got it!", style: NSAlertStyle.critical)
    }
    
    internal func copyToPasteboard(_ text: String)
    {
        let pasteboard = NSPasteboard.general()
        pasteboard.clearContents()
        pasteboard.setString(text, forType: NSPasteboardTypeString)
    }

    fileprivate func showAlert(_ title: String, message: String, buttonTitle: String, style: NSAlertStyle)
    {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.addButton(withTitle: buttonTitle)
        alert.alertStyle = style
        alert.beginSheetModal(for: NSApplication.shared().mainWindow!, completionHandler: nil)
    }

    fileprivate func setupView()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(hexString: DonoViewController.PrimaryColor)?.withAlphaComponent(1).cgColor
    }
}
