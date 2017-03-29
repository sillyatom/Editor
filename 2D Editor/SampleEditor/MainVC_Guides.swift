//
//  MainVC_Guides.swift
//  SampleEditor
//
//  Created by Sillyatom on 29/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Foundation
import Cocoa

extension MainVC
{
    func drawGuideOnTop(for child: NSView, target: NSView)
    {
        let view = self.view as! MainSceneView
        let keyExists = view.guides[child] != nil
        var path:NSBezierPath!
        if !keyExists
        {
            path = NSBezierPath()
            path.lineWidth = 1
            path.move(to: NSPoint(x: child.frame.midX, y: child.frame.maxY))
            path.line(to: NSPoint(x: target.frame.midX, y: child.frame.maxY))
        }
        else
        {
            path = view.guides[child] as! NSBezierPath
            path.removeAllPoints()
            path.move(to: NSPoint(x: child.frame.midX, y: child.frame.maxY))
            path.line(to: NSPoint(x: target.frame.midX, y: child.frame.maxY))
        }
        
        path.setLineDash([15.0, 15.0], count: 2, phase: 0)
        view.guides.updateValue(path, forKey: child)
        self.view.needsDisplay = true
    }
    
    func drawGuideOnBottom()
    {
        
    }
    
    func drawGuideOnLeft()
    {
        
    }
    
    func drawGuideOnRight()
    {
        
    }
    
    func removeallGuides()
    {
        
    }
}
