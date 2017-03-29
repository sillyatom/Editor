//
//  ViewController.swift
//  SampleEditor
//
//  Created by Sillyatom on 16/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Cocoa

enum Appearance
{
    static let maxStickerDimension: CGFloat = 150.0
    static let shadowOpacity: Float =  0.4
    static let shadowOffset: CGFloat = 4
    static let imageCompressionFactor = 1.0
    static let maxRotation: UInt32 = 12
    static let rotationOffset: CGFloat = 6
    static let randomNoise: UInt32 = 200
    static let numStars = 20
    static let maxStarSize: CGFloat = 30
    static let randonStarSizeChange: UInt32 = 25
    static let randomNoiseStar: UInt32 = 100
}

enum MouseDirection
{
    static let neutral:Int = 0
    static let up: Int = 1
    static let down: Int = -1
    static let left: Int = -2
    static let right: Int = 2
}

class MainVC: NSViewController
{
    @IBOutlet var topLayer: MainSceneView!

    var isDragging: Bool = false

    var mouseMovingDirection: Int!
    var lastMousePosition: NSPoint!
    var deltaMousePosition: Float!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        topLayer.delegate = self
    }
    
    override func mouseDown(with event: NSEvent)
    {
        let screenPoint: NSPoint = NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        lastMousePosition = screenPoint
        deltaMousePosition = Helper.distance(point1: lastMousePosition, point2: screenPoint)
        
        //check for selection and drag selection
        checkSelectionOnMouseDown(with: event)
        
        //update guides
        //
        //
    }
    
    override func mouseUp(with event: NSEvent)
    {
        //check for selection and drag selection
        checkSelectionOnMouseUp(with: event)
        
        //update guides
        //
        //
    }
    
    override func mouseDragged(with event: NSEvent)
    {
        let screenPoint: NSPoint = NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        deltaMousePosition = Helper.distance(point1: lastMousePosition, point2: screenPoint)
        
        //update direction
        updateDirection(with: event)
        
        //check for selection and drag selection
        checkSelectionOnMouseDragged(with: event)
        
        //update guides
        if topLayer.subviews.count > 1
        {
            updateGuidesOnMouseDragged(with: event)
        }
        
        lastMousePosition = screenPoint
    }
}
