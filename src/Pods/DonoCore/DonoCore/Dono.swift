// Dono Key Derivation Function
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

import CryptoSwift
import Foundation

open class Dono
{
    open static var MIN_KEY_LENGTH = 17

    fileprivate static var Iterations : [Int] =
        [
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            Int.max,
            1298863,
            49955,
            1920,
            72,
            1,
        ]
    
    fileprivate static var MagicSalt = "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b"
    
    public init() { }
    
    open func computePassword(_ k: String, l: String) -> String?
    {
        if (k.characters.count < Dono.MIN_KEY_LENGTH)
        {
            return nil
        }
        
        var label = l.lowercased()
        label = label.trim()
        
        
        let c = getIterations(k)
        
        let d = derivePassword(k, l: label, c: c)
        
        return d
    }
    
    fileprivate func derivePassword(_ k: String, l: String, c: Int) -> String
    {
        let password: [UInt8] = k.utf8.map {$0}
        
        let s = (k + l + Dono.MagicSalt).sha256()
        
        let salt: [UInt8] = s.utf8.map {$0}
        
        let d = try! PKCS5.PBKDF2(password: password, salt: salt, iterations: c, keyLength: 256, variant: .sha256)
                            .calculate()
                            .toHexString()
                            .characters
        
        return String(d)
    }

    fileprivate func getIterations(_ k: String) -> Int
    {
        if (k.characters.count < Dono.Iterations.count)
        {
            return Dono.Iterations[k.characters.count]
        }
        else
        {
            return Dono.Iterations[Dono.Iterations.count - 1]
        }
    }
}
