//
//  MainVC_MouseUpExt.swift
//  SampleEditor
//
//  Created by Sillyatom on 28/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Foundation
import Cocoa

extension MainVC
{
    func checkSelectionOnMouseUp(with event: NSEvent)
    {
        //if dragging end the drag session
        if isDragging
        {
            topLayer.endSelection(with: event)
        }
            //if there are no objects under mouse click location uncheck the highlights
        else
        {
            let screenPoint: NSPoint = NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
            if !topLayer.hasObjectUnderPosition(point: screenPoint)
            {
                topLayer.checkForHighlights(mouseLocation: nil)
            }
        }
        isDragging = false
        
        self.view.needsDisplay = true
    }
}
