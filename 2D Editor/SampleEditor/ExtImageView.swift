//
//  ExtImageView.swift
//  SampleEditor
//
//  Created by Sillyatom on 25/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Cocoa

class ExtImageView: NSImageView, EditorObject
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
            selectionView?.isHidden = !newValue
            self.needsDisplay = true
        }
    }
    
    private var _selectionView: NSView?
    var selectionView: NSView?
    {
        get
        {
            return _selectionView
        }
        set
        {
            _selectionView = newValue
        }
    }
    
    func getView() -> NSView
    {
        return self as NSView
    }
    
    override func draw(_ dirtyRect: NSRect)
    {
        // Drawing code here.
        NSColor.clear.set()
        
        if isHighlighted
        {
            super.draw(dirtyRect)
            
            layer?.opacity = 0.75
        }
        else
        {
            layer?.opacity = 1.0
            
            NSBezierPath.fill(dirtyRect)
            super.draw(dirtyRect)
        }
    }
    
    func updateSelectionView()
    {
        selectionView?.setFrameOrigin(NSPoint(x: self.frame.minX, y: self.frame.maxY))
    }
}
