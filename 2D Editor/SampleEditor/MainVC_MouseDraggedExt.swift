//
//  MainVC_MouseDraggedExt.swift
//  SampleEditor
//
//  Created by Sillyatom on 28/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Foundation
import Cocoa

extension MainVC
{
    func updateDirection(with event: NSEvent)
    {
        let screenPoint: NSPoint = NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        
        let xDistance: CGFloat = screenPoint.x - lastMousePosition.x
        let yDistance: CGFloat = screenPoint.y - lastMousePosition.y
        
        if xDistance > yDistance
        {
            if screenPoint.x - lastMousePosition.x > 0
            {
                mouseMovingDirection = MouseDirection.right
            }
            else
            {
                mouseMovingDirection = MouseDirection.left
            }
        }
        else if xDistance < yDistance
        {
            if screenPoint.y - lastMousePosition.y > 0
            {
                mouseMovingDirection = MouseDirection.up
            }
            else
            {
                mouseMovingDirection = MouseDirection.down
            }
        }
        else
        {
            mouseMovingDirection = MouseDirection.neutral
        }
    }
    
    func checkSelectionOnMouseDragged(with event: NSEvent)
    {
        isDragging = true
        
        //drag multiple objects
        if topLayer.currentSelection.count != 0
        {
            for child in topLayer.currentSelection
            {
                let selectedChild = (child as? SelectedEditorObject)!
                let screenPoint: NSPoint = NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y);
                let calcPoint: NSPoint = NSPoint(x: screenPoint.x - selectedChild.offPoint.x,
                                                 y: screenPoint.y - selectedChild.offPoint.y)
                selectedChild.editorObj.getView().setFrameOrigin(calcPoint)
            }
        }
        else
        {
            //update drag selection
            topLayer.dragSelection(with: event)
        }
    }
    
    func updateGuidesOnMouseDragged(with event: NSEvent)
    {
        let currentSelection: NSView = (topLayer.currentSelection.object(at: 0) as! SelectedEditorObject).editorObj as! NSView
        for child in topLayer.subviews
        {
            if child != currentSelection
            {
                
            }
            else
            {
                //skip if itself
                continue;
            }
            
            drawGuideOnTop(for: child, target: currentSelection)
            
            var distance = Helper.distance(point1: currentSelection.frame.midY, point2: child.frame.midY)
            distance = abs(distance)
            if distance <= 10
            {
                currentSelection.frame = NSRect(x: currentSelection.frame.minX, y: child.frame.minY, width: currentSelection.frame.width, height: currentSelection.frame.height)
            }
        }
    }
}
