// Dono OS X - Password Derivation Tool
// Copyright (C) 2016  Panos Sakkos
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
    }
}
