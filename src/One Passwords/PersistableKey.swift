//
//  PersistableKey.swift
//  One Passwords
//
//  Created by Ghost on 3/3/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation
import KeychainSwift

internal class PersistableKey
{
    private static var KEYCHAIN_KEY = "dono.key"
    
    static var Key = String();
    
    let keychain = KeychainSwift()
    let settings = Settings()
    
    internal func getKey() -> String
    {
        if (!PersistableKey.Key.isEmpty)
        {
            return PersistableKey.Key;
        }
        
        self.load();
        
        return PersistableKey.Key;
    }
    
    internal func setkey(key: String)
    {
        if (key != PersistableKey.Key)
        {
            PersistableKey.Key = key;
            self.save();
        }
    }
    
    internal func delete()
    {
        PersistableKey.Key = String()
        self.keychain.delete(PersistableKey.KEYCHAIN_KEY)
    }
    
    internal func save()
    {
        if (self.settings.getRememberKeyValue())
        {
            self.keychain.set(PersistableKey.Key, forKey: PersistableKey.KEYCHAIN_KEY)
        }
    }
    
    private func load()
    {
        if (self.settings.getRememberKeyValue())
        {
            PersistableKey.Key = self.keychain.get(PersistableKey.KEYCHAIN_KEY) ?? String()
        }
    }
}