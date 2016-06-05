//
//  SettingsViewController.swift
//  Dono
//
//  Created by Ghost on 6/4/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Cocoa

class SettingsViewController : DonoViewController
{
    @IBOutlet weak var rememberKeyToggle: NSButton!
    
    var settings = Settings()
    
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
