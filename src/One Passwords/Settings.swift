//
//  Settings.swift
//  Dono
//
//  Created by Ghost on 6/4/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation

class Settings
{
    var REMEMBER_KEY_KEY = "rememberKey"
    
    internal func getRememberKeyValue() -> Bool
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        return defaults.boolForKey(REMEMBER_KEY_KEY)
    }
    
    internal func setRememberKeyValue(value: Bool)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(value, forKey: REMEMBER_KEY_KEY)
    }
}