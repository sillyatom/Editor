//
//  MainVC_MouseDownExt.swift
//  SampleEditor
//
//  Created by Sillyatom on 28/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Foundation
import Cocoa

extension MainVC
{
    func checkSelectionOnMouseDown(with event: NSEvent)
    {
        let screenPoint: NSPoint = NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        
        //if there are no objects under click location
        if !topLayer.hasObjectUnderPosition(point: screenPoint)
        {
            //unhighlight all
            topLayer.checkForHighlights(mouseLocation: nil)
        }
        else
        {
            //if there is some object under click position
            //and if there is one object or none selected then update the highlight
            //if current selection count is less than or equals ONE then update highlight
            if topLayer.currentSelection.count <= 1
            {
                topLayer.checkForHighlights(mouseLocation: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
            }
        }
        
        //if current selection is more than zero, update the offPoint for dragging
        if topLayer.currentSelection.count != 0
        {
            for child in topLayer.currentSelection
            {
                let selectedChild = (child as? SelectedEditorObject)!
                let screenPoint: NSPoint = NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
                selectedChild.offPoint = self.view.convert(screenPoint, to: selectedChild.editorObj.getView())
            }
        }
            //if current selection is zero start drag selection
        else
        {
            topLayer.startSelection(with: event)
        }
    }
}
