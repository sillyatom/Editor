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
    
    private func initPaths(for child: NSView)
    {
        let view = self.view as! MainSceneView
        let keyExists = view.guides[child] != nil
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
    }
    func drawGuideOnTop(for child: NSView, target: NSView)
    {
        initPaths(for: child)
        let view = self.view as! MainSceneView
        var path:NSBezierPath!
        path = view.guides[child]?[GuideSides.top] as! NSBezierPath
        path.removeAllPoints()
        path.move(to: NSPoint(x: child.frame.midX, y: child.frame.maxY))
        path.line(to: NSPoint(x: target.frame.midX, y: child.frame.maxY))
        
        view.guides[child]?[GuideSides.top] = path
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
    }
    
    func drawGuideOnBottom(for child: NSView, target: NSView)
    {
        initPaths(for: child)
        let view = self.view as! MainSceneView
        var path:NSBezierPath!
        path = view.guides[child]?[GuideSides.bottom] as! NSBezierPath
        path.removeAllPoints()
        path.move(to: NSPoint(x: child.frame.midX, y: child.frame.minY))
        path.line(to: NSPoint(x: target.frame.midX, y: child.frame.minY))
        
        view.guides[child]?[GuideSides.bottom] = path
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
    }
    
    func drawGuideOnLeft(for child: NSView, target: NSView)
    {
        initPaths(for: child)
        let view = self.view as! MainSceneView
        var path:NSBezierPath!
        path = view.guides[child]?[GuideSides.left] as! NSBezierPath
        path.removeAllPoints()
        path.move(to: NSPoint(x: child.frame.minX, y: child.frame.midY))
        path.line(to: NSPoint(x: child.frame.minX, y: target.frame.midY))
        
        view.guides[child]?[GuideSides.left] = path
    }
    
    func removeGuideOnLeft(for child: NSView, target: NSView)
    {
        let view = self.view as! MainSceneView
        let keyExists = view.guides[child] != nil
        var path:NSBezierPath!
        if keyExists
        {
            if (view.guides[child]?[GuideSides.left]) != nil
            {
                path = view.guides[child]?[GuideSides.left] as! NSBezierPath
                path.removeAllPoints()
                view.guides[child]?[GuideSides.left] = path
            }
        }
    }
    
    func drawGuideOnRight(for child: NSView, target: NSView)
    {
        initPaths(for: child)
        let view = self.view as! MainSceneView
        var path:NSBezierPath!
        path = view.guides[child]?[GuideSides.right] as! NSBezierPath
        path.removeAllPoints()
        path.move(to: NSPoint(x: child.frame.maxX, y: child.frame.midY))
        path.line(to: NSPoint(x: child.frame.maxX, y: target.frame.midY))
        
        view.guides[child]?[GuideSides.right] = path
    }
    
    func removeGuideOnRight(for child: NSView, target: NSView)
    {
        let view = self.view as! MainSceneView
        let keyExists = view.guides[child] != nil
        var path:NSBezierPath!
        if keyExists
        {
            if (view.guides[child]?[GuideSides.right]) != nil
            {
                path = view.guides[child]?[GuideSides.right] as! NSBezierPath
                path.removeAllPoints()
                view.guides[child]?[GuideSides.right] = path
            }
        }
    }
}
