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

let labelsfilename = "~/.labels";
let pathToServiceTagsFile = (labelsfilename as NSString).expandingTildeInPath

internal class PersistableLabels
{
    var labels = [String]()
    
    internal func add(_ label: String) -> String
    {
        let l = self.canonical(label)
        
        if (self.labels.contains(l))
        {
            return String()
        }
        
        self.labels.insert(l, at: self.labels.count)
        self.labels.sort()
        self.saveLabels()
        
        return l
    }
    
    internal func getAll() -> [String]
    {
        self.loadLabels()
        self.labels.sort()
        
        return self.labels
    }
    
    internal func getAt(_ position: Int) -> String
    {
        var ret = String();
        
        for (i, label) in self.labels.enumerated()
        {
            if (i == position)
            {
                ret = label;
            }
        }
        
        return ret;
    }
    
    
    internal func deleteAt(_ position: Int) -> String
    {
        if (position < 0)
        {
            return String()
        }
        
        let ret = self.labels.remove(at: position);
        
        self.saveLabels();
        
        return ret;
    }
    
    internal func count() -> Int
    {
        return self.labels.count;
    }
    
    internal func canonical(_ label: String) -> String
    {
        var l = label.lowercased()
        l = l.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        return l
    }
    
    fileprivate func saveLabels()
    {
        var dump = String()
        
        for (_, label) in self.labels.enumerated()
        {
            dump += label + "\n"
        }
        
        do
        {
            try dump.write(toFile: pathToServiceTagsFile, atomically: false, encoding: String.Encoding.utf8)
        }
        catch
        {
        }
    }
    
    fileprivate func loadLabels()
    {
        do
        {
            self.labels.removeAll()
            
            let labels = try String(contentsOfFile: pathToServiceTagsFile, encoding: String.Encoding.utf8).characters.split(separator: "\n")
            
            for (_, label) in labels.enumerated()
            {
                self.labels.insert(String(label), at: 0)
            }
            
            self.labels.sort()
        }
        catch
        {
        }
    }
}
