//
//  MainVC_Guides.swift
//  SampleEditor
//
//  Created by Sillyatom on 29/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Foundation
import Cocoa

enum GuideSides
{
    static let top = 0
    static let bottom = 1
    static let left = 2
    static let right = 3
}

extension MainVC
{
    func drawGuideOnTop(for child: NSView, target: NSView)
    {
        let view = self.view as! MainSceneView
        let keyExists = view.guides[child] != nil
        
        var path:NSBezierPath!
        
        if !keyExists
        {
            view.guides[child] = NSMutableArray()
            
            for _ in 0...3
            {
                let newPath = NSBezierPath()
                newPath.lineWidth = 1
                newPath.setLineDash([15.0, 15.0], count: 2, phase: 0)
                view.guides[child]?.add(newPath)
            }
        }
        
        path = view.guides[child]?[GuideSides.top] as! NSBezierPath
        path.removeAllPoints()
        path.move(to: NSPoint(x: child.frame.midX, y: child.frame.maxY))
        path.line(to: NSPoint(x: target.frame.midX, y: child.frame.maxY))
        
        view.guides[child]?[GuideSides.top] = path
        self.view.needsDisplay = true
    }
    
    func removeGuideOnTop(for child: NSView, target: NSView)
    {
        let view = self.view as! MainSceneView
        let keyExists = view.guides[child] != nil
        var path:NSBezierPath!
        if keyExists
        {
            if (view.guides[child]?[GuideSides.top]) != nil
            {
                path = view.guides[child]?[GuideSides.top] as! NSBezierPath
                path.removeAllPoints()
                view.guides[child]?[GuideSides.top] = path
            }
        }
        
        self.view.needsDisplay = true
    }
    
    func drawGuideOnBottom(for child: NSView, target: NSView)
    {
        let view = self.view as! MainSceneView
        let keyExists = view.guides[child] != nil
        
        var path:NSBezierPath!
        
        if !keyExists
        {
            view.guides[child] = NSMutableArray()
            
            for _ in 0...3
            {
                let newPath = NSBezierPath()
                newPath.lineWidth = 1
                newPath.setLineDash([15.0, 15.0], count: 2, phase: 0)
                view.guides[child]?.add(newPath)
            }
        }
        
        path = view.guides[child]?[GuideSides.bottom] as! NSBezierPath
        path.removeAllPoints()
        path.move(to: NSPoint(x: child.frame.midX, y: child.frame.minY))
        path.line(to: NSPoint(x: target.frame.midX, y: child.frame.minY))
        
        view.guides[child]?[GuideSides.bottom] = path
        self.view.needsDisplay = true
    }
    
    func removeGuideOnBottom(for child: NSView, target: NSView)
    {
        let view = self.view as! MainSceneView
        let keyExists = view.guides[child] != nil
        var path:NSBezierPath!
        if keyExists
        {
            if (view.guides[child]?[GuideSides.bottom]) != nil
            {
                path = view.guides[child]?[GuideSides.bottom] as! NSBezierPath
                path.removeAllPoints()
                view.guides[child]?[GuideSides.bottom] = path
            }
        }
        
        self.view.needsDisplay = true
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
