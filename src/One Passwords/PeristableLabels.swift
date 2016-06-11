//
//  PersistableLabels.swift
//  One Passwords
//
//  Created by Ghost on 3/2/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation

let docsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;

let labelsfilename = "/.service-tags";
let pathToServiceTagsFile = docsFolder.stringByAppendingString(labelsfilename);

internal class PersistableLabels
{
    var labels = [String]()
    
    internal func add(label: String) -> String
    {
        let l = self.canonical(label)
        
        if (self.labels.contains(l))
        {
            return String()
        }
        
        self.labels.insert(l, atIndex: self.labels.count)
        self.labels.sortInPlace()
        self.saveLabels()
        
        return l
    }
    
    internal func getAll() -> [String]
    {
        self.loadLabels()
        self.labels.sortInPlace()
        
        return self.labels
    }
    
    internal func getAt(position: Int) -> String
    {
        var ret = String();
        
        for (i, label) in self.labels.enumerate()
        {
            if (i == position)
            {
                ret = label;
            }
        }
        
        return ret;
    }
    
    
    internal func deleteAt(position: Int) -> String
    {
        if (position < 0)
        {
            return String()
        }
        
        let ret = self.labels.removeAtIndex(position);
        
        self.saveLabels();
        
        return ret;
    }
    
    internal func count() -> Int
    {
        return self.labels.count;
    }
    
    internal func canonical(label: String) -> String
    {
        var l = label.lowercaseString
        l = l.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        return l
    }
    
    private func saveLabels()
    {
        var dump = String()
        
        for (_, label) in self.labels.enumerate()
        {
            dump += label + "\n"
        }
        
        do
        {
            try dump.writeToFile(pathToServiceTagsFile, atomically: false, encoding: NSUTF8StringEncoding)
        }
        catch
        {
        }
    }
    
    private func loadLabels()
    {
        do
        {
            self.labels.removeAll()
            
            let labels = try String(contentsOfFile: pathToServiceTagsFile, encoding: NSUTF8StringEncoding).characters.split("\n")
            
            for (_, label) in labels.enumerate()
            {
                self.labels.insert(String(label), atIndex: 0)
            }
            
            self.labels.sortInPlace()
        }
        catch
        {
        }
    }
}