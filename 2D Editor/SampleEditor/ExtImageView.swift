//
//  ExtImageView.swift
//  SampleEditor
//
//  Created by Sillyatom on 25/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Cocoa

class ExtImageView: NSImageView
{
    private var _highlighted:Bool = false
    override var isHighlighted:Bool
    {
        get
        {
            return _highlighted
        }
        set
        {
            _highlighted = newValue
            self.needsDisplay = true
        }
        
    }
    
    override func draw(_ dirtyRect: NSRect)
    {
        // Drawing code here.
        NSColor.clear.set()
        
        if isHighlighted
        {
            super.draw(dirtyRect)
            
            layer?.borderWidth = 4.0
            layer?.cornerRadius = 8.0
            layer?.masksToBounds = true
            layer?.opacity = 0.25
            
            NSColor.red.set()
            NSBezierPath.setDefaultLineWidth(4.0)
            NSBezierPath.stroke(frame)
        }
        else
        {
            layer?.borderWidth = 0.0
            layer?.cornerRadius = 0.0
            layer?.opacity = 1.0
            
            NSBezierPath.fill(dirtyRect)
            super.draw(dirtyRect)
        }
    }
}
