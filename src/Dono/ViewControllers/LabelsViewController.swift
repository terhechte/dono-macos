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
        self.labelsTableView.setDelegate(self)
        self.labelsTableView.setDataSource(self)
        self.labelsTableView.target = self
        self.labelsTableView.doubleAction = #selector(LabelsViewController.tableViewDoubleClick(_:))
        
        self.lonelyLabel.cell?.title = "Feels lonely in here!\n\nAdd Labels in order to derive passwords for them"

        self.refreshLabels()
    }
    
    override func viewWillAppear()
    {
        super.viewWillAppear()
        
        self.labels.getAll()
        self.labelsTableView.reloadData()
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?)
    {
        let destinationViewController = segue.destinationController
        
        if (destinationViewController is AddLabelViewController)
        {
            (destinationViewController as! AddLabelViewController).labelsViewController = self
        }
    }

    override var representedObject: AnyObject?
        {
        didSet
        {
            // Update the view, if already loaded.
        }
    }

    @IBAction func deleteLabel(sender: AnyObject)
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
            self.lonelyLabel.hidden = false
            self.labelsTableView.hidden = true
        }
        else
        {
            self.lonelyLabel.hidden = true
            self.labelsTableView.hidden = false
        }
    }
    
    //TableView Data Source
    func numberOfRowsInTableView(tableView: NSTableView) -> Int
    {
        return self.labels.count()
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        if let cell = tableView.makeViewWithIdentifier("LabelCellID", owner: nil) as? NSTableCellView
        {
            cell.textField?.stringValue = self.labels.getAt(row)

            return cell
        }
        
        return nil
    }
        
    func tableViewDoubleClick(sender: AnyObject)
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
}