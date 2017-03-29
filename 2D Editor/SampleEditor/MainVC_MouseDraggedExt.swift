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
                selectedChild.editorObj.updateSelectionView()
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
        if topLayer.currentSelection.count == 0
        {
            return
        }
        
        let currentSelection: NSView = (topLayer.currentSelection.object(at: 0) as! SelectedEditorObject).editorObj as! NSView
        for child in topLayer.subviews
        {
            if child is EditorObject == false
            {
                continue
            }
            if child != currentSelection
            {
                
            }
            else
            {
                //skip if itself
                continue;
            }
            
            //for top guide
            var distance = Helper.distance(point1: currentSelection.frame.maxY, point2: child.frame.maxY)
            distance = abs(distance)
            
            if distance <= 50
            {
                drawGuideOnTop(for: child, target: currentSelection)
            }
            else
            {
                removeGuideOnTop(for: child, target: currentSelection)
            }
            if distance <= 10
            {
                currentSelection.frame = NSRect(x: currentSelection.frame.minX, y: child.frame.minY, width: currentSelection.frame.width, height: currentSelection.frame.height)
            }
            
            //for bottom guide
            distance = Helper.distance(point1: currentSelection.frame.minY, point2: child.frame.minY)
            distance = abs(distance)
            
            if distance <= 50
            {
                drawGuideOnBottom(for: child, target: currentSelection)
            }
            else
            {
                removeGuideOnBottom(for: child, target: currentSelection)
            }
            if distance <= 10
            {
                currentSelection.frame = NSRect(x: currentSelection.frame.minX, y: child.frame.minY, width: currentSelection.frame.width, height: currentSelection.frame.height)
            }
        }
    }
}
