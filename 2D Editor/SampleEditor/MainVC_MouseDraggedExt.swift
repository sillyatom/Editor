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
        
        let selectedChild: SelectedEditorObject = (topLayer.currentSelection.object(at: 0) as! SelectedEditorObject)
        let currentSelection: NSView = selectedChild.editorObj as! NSView
        let currentPosition: NSPoint = NSPoint(x: currentSelection.frame.midX, y: currentSelection.frame.midY)
        
        var childs: [NSView] = topLayer.subviews
        childs.sort{
            (view1: NSView, view2: NSView)->Bool in
                    return Helper.distance(point1: currentPosition, point2: NSPoint(x: view1.frame.midX, y: view1.frame.midY)) < Helper.distance(point1: currentPosition, point2: NSPoint(x: view2.frame.midX, y: view2.frame.midY))
        }
        
        for child in childs
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
            
            //for top(child) - bottom(selection) guide
            distance = Helper.distance(point1: currentSelection.frame.minY, point2: child.frame.maxY)
            distance = abs(distance)
            if distance <= 50
            {
                drawGuideOnTop(for: child, target: currentSelection)
            }
            if distance <= 10
            {
                currentSelection.frame = NSRect(x: currentSelection.frame.minX, y: child.frame.maxY, width: currentSelection.frame.width, height: currentSelection.frame.height)
            }
            
            //for bottom(child) - top guide(selection)
            distance = Helper.distance(point1: currentSelection.frame.maxY, point2: child.frame.minY)
            distance = abs(distance)
            if distance <= 50
            {
                drawGuideOnBottom(for: child, target: currentSelection)
            }
            if distance <= 10
            {
                currentSelection.frame = NSRect(x: currentSelection.frame.minX, y: child.frame.minY - currentSelection.frame.height, width: currentSelection.frame.width, height: currentSelection.frame.height)
            }

            //for left guide
            distance = Helper.distance(point1: currentSelection.frame.minX, point2: child.frame.minX)
            distance = abs(distance)
            if distance <= 50
            {
                drawGuideOnLeft(for: child, target: currentSelection)
            }
            else
            {
                removeGuideOnLeft(for: child, target: currentSelection)
            }
            if distance <= 10
            {
                currentSelection.frame = NSRect(x: child.frame.minX, y: currentSelection.frame.minY, width: currentSelection.frame.width, height: currentSelection.frame.height)
            }
            
            //for right guide
            distance = Helper.distance(point1: currentSelection.frame.maxX, point2: child.frame.maxX)
            distance = abs(distance)
            if distance <= 50
            {
                drawGuideOnRight(for: child, target: currentSelection)
            }
            else
            {
                removeGuideOnRight(for: child, target: currentSelection)
            }
            if distance <= 10
            {
                currentSelection.frame = NSRect(x: child.frame.minX, y: currentSelection.frame.minY, width: currentSelection.frame.width, height: currentSelection.frame.height)
            }
            
            //for left(child) && right(current selection)
            distance = Helper.distance(point1: currentSelection.frame.minX, point2: child.frame.maxX)
            distance = abs(distance)
            if distance <= 50
            {
                drawGuideOnRight(for: child, target: currentSelection)
            }
            if distance <= 10
            {
                currentSelection.frame = NSRect(x: child.frame.maxX, y: currentSelection.frame.minY, width: currentSelection.frame.width, height: currentSelection.frame.height)
            }
            
            //for right(child) && left(current selection)
            distance = Helper.distance(point1: currentSelection.frame.maxX, point2: child.frame.minX)
            distance = abs(distance)
            if distance <= 50
            {
                drawGuideOnLeft(for: child, target: currentSelection)
            }
            if distance <= 10
            {
                currentSelection.frame = NSRect(x: child.frame.minX - currentSelection.frame.width, y: currentSelection.frame.minY, width: currentSelection.frame.width, height: currentSelection.frame.height)
            }
            
            selectedChild.editorObj.updateSelectionView()
        }
        
        if topLayer.getEditorObjChildcount() > 1
        {
            self.view.needsDisplay = true
        }
    }
}
