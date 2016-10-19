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
import SwiftHEXColors
import Carbon

class LabelsViewController : DonoViewController, NSTableViewDataSource, NSTableViewDelegate
{
    @IBOutlet weak var labelsTableView: NSTableView!

    @IBOutlet weak var lonelyLabel: NSTextField!
    
    let dono = Dono()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.labels.getAll()
        self.labelsTableView.delegate = self
        self.labelsTableView.dataSource = self
        self.labelsTableView.target = self
        self.labelsTableView.doubleAction = #selector(LabelsViewController.tableViewDoubleClick(_:))
        
        self.lonelyLabel.cell?.title = "Feels lonely in here!\n\n\n\n\n\nAdd Labels to derive passwords from them"

        self.refreshLabels()
    }
    
    override func viewWillAppear()
    {
        super.viewWillAppear()
        
        self.labels.getAll()
        self.labelsTableView.reloadData()
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?)
    {
        let destinationViewController = segue.destinationController
        
        if (destinationViewController is AddLabelViewController)
        {
            (destinationViewController as! AddLabelViewController).labelsViewController = self
        }
    }

    @IBAction func deleteLabel(_ sender: AnyObject)
    {
        let labelToDelete = self.labelsTableView.selectedRow
        self.labels.deleteAt(labelToDelete)
        self.refreshLabels()
    }
    
    func refreshLabels()
    {
        self.labels.getAll()
        self.labelsTableView.reloadData()

        if (self.labels.count() == 0)
        {
            self.lonelyLabel.isHidden = false
            self.labelsTableView.isHidden = true
        }
        else
        {
            self.lonelyLabel.isHidden = true
            self.labelsTableView.isHidden = false
        }
    }
    
    //TableView Data Source
    func numberOfRows(in tableView: NSTableView) -> Int
    {
        return self.labels.count()
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        if let cell = tableView.make(withIdentifier: "LabelCellID", owner: nil) as? NSTableCellView
        {
            cell.textField?.stringValue = self.labels.getAt(row)

            return cell
        }
        
        return nil
    }
        
    func tableViewDoubleClick(_ sender: AnyObject)
    {
        if (self.labelsTableView.selectedRow >= 0)
        {
            let key = self.key.getKey()
            
            if (key.isEmpty)
            {
                self.showCrititcalAlert(
                    "No Key is set!",
                    message: "You need to set your Key in order to derive passwords for your Labels")

                return
            }
            
            let label = self.labels.getAt(self.labelsTableView.selectedRow)
            
            let d = self.dono.computePassword(key, l: label)
            
            self.copyToPasteboard(d!);
                        
            self.showInfoAlert(
                "Password derived",
                message: "Your password for " + label + " is ready to be pasted!",
                buttonTitle: "Awesome!")
        }
    }
    
    // MARK:- UIResponder keyDown
    override func keyDown(with event: NSEvent) {
        print(self.labels.count())
        if event.keyCode == 36 { // return
            self.tableViewDoubleClick(self)
        } else if event.keyCode == 48 { // tab
            let selected = labelsTableView.selectedRow
            var next = selected
            if event.modifierFlags.contains(NSEventModifierFlags.shift) {
                if selected == 0 {
                    next = (self.labels.count() - 1)
                } else {
                    next -= 1
                }
            } else {
                if selected >= (self.labels.count() - 1) {
                    next = 0
                } else {
                    next += 1
                }
            }
            labelsTableView.selectRowIndexes(IndexSet(integer: next), byExtendingSelection: false)
        }
    }
}
