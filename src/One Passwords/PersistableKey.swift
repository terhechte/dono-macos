//
//  PersistableKey.swift
//  One Passwords
//
//  Created by Ghost on 3/3/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation
import KeychainSwift

let keyFileName = "/.key";
let pathToKeyFile = docsFolder.stringByAppendingString(keyFileName);

internal class PersistableKey
{
    private static var KEYCHAIN_KEY = "dono.key"
    
    static var Key = "";
    let keychain = KeychainSwift()
    
    internal func getKey() -> String
    {
        if (PersistableKey.Key != "")
        {
            return PersistableKey.Key;
        }
        
        loadKey();
        
        return PersistableKey.Key;
    }
    
    internal func setkey(key: String)
    {
        if (key != PersistableKey.Key)
        {
            PersistableKey.Key = key;
            saveKey();
        }
    }
    
    private func loadKey()
    {
        PersistableKey.Key = self.keychain.get(PersistableKey.KEYCHAIN_KEY) ?? ""
    }
    
    private func saveKey()
    {
        self.keychain.set(PersistableKey.Key, forKey: PersistableKey.KEYCHAIN_KEY)
    }
}