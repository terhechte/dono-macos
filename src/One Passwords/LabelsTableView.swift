//
//  LabelsTableView.swift
//  Dono
//
//  Created by Ghost on 6/3/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Cocoa

class LabelTableCellView : NSTableCellView
{
    override var backgroundStyle:NSBackgroundStyle{
        //check value when the style was setted
        didSet{
            //if it is dark the cell is highlighted -> apply the app color to it
            if backgroundStyle == .Dark{
                self.layer?.backgroundColor = NSColor(hexString: DonoViewController.SecondaryText)?.CGColor
            }
                //else go back to the standard color
            else{
                self.layer?.backgroundColor = NSColor.clearColor().CGColor
            }
        }
    }}
