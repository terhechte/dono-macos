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