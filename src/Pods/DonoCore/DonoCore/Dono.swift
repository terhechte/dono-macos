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
import IDZSwiftCommonCrypto

open class Dono
{
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
    
    public init() { }
    
    open func computePassword(_ k: String, l: String) -> String?
    {
        if (k.characters.count < DonoConstants.MIN_KEY_LENGTH)
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
        let s = (k + l + DonoConstants.MagicSalt).sha256()
        
        let salt: [UInt8] = s.utf8.map {$0}
        
        let d = PBKDF.deriveKey(password: k, salt: salt, prf: .sha256, rounds: uint(UInt(c)), derivedKeyLength: UInt(32))
                .toBase64()!
        
        return d
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
