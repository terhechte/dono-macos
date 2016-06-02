//
//  ViewController.swift
//  One Passwords
//
//  Created by Ghost on 3/14/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Cocoa
import DonoCore
import SwiftHEXColors

class LabelsViewController : DonoViewController, NSTableViewDataSource, NSTableViewDelegate
{
    @IBOutlet weak var labelsTableView: NSTableView!
    
    let labels = PersistableLabels()
    let key = PersistableKey()
    let dono = Dono()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.labels.getAll()
        
        self.labelsTableView.setDelegate(self)
        self.labelsTableView.setDataSource(self)
        self.labelsTableView.target = self
        self.labelsTableView.doubleAction = #selector(LabelsViewController.tableViewDoubleClick(_:))
    }
    
    @IBAction func deleteLabel(sender: AnyObject)
    {
        let labelToDelete = self.labelsTableView.selectedRow
        self.labels.deleteAt(labelToDelete)
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
    
    func refreshLabels()
    {
        self.labels.getAll()
        self.labelsTableView.reloadData()
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
                self.showCrititcalAlert("No Key is set!",
                                        message: "You need to set your Key in order to derive passwords for your Labels!",
                                        buttonTitle: "Got it!")

                return
            }
            
            let label = self.labels.getAt(self.labelsTableView.selectedRow)
            
            let d = self.dono.computePassword(key, l: label)
            copyToPasteboard(d);
                        
            self.showInfoAlert("Password retrieved", message: "Your password for " + label + " is ready to be pasted!", buttonTitle: "Awesome!")
        }
    }
}