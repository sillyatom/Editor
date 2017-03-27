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

class MainVC: NSViewController
{
    @IBOutlet var topLayer: MainSceneView!
    var isDragging: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        topLayer.delegate = self
    }
    
    override func mouseDown(with event: NSEvent)
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
    
    override func mouseUp(with event: NSEvent)
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
    }

    override func mouseDragged(with event: NSEvent)
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
}

// MARK: - DestinationViewDelegate
extension MainVC: DestinationViewDelegate
{
    func processImage(_ image: NSImage, center: NSPoint)
    {
        let constrainedSize = image.aspectFitSizeForMaxDimension(Appearance.maxStickerDimension)
        
        //3.
        let subview = ExtImageView(frame:NSRect(x: center.x - constrainedSize.width/2, y: center.y - constrainedSize.height/2, width: constrainedSize.width, height: constrainedSize.height))
        subview.image = image
        view.addSubview(subview)
        
        //4.
//        let maxrotation = CGFloat(arc4random_uniform(Appearance.maxRotation)) - Appearance.rotationOffset
//        subview.frameCenterRotation = maxrotation
        
    }
    
    func processImageURLs(_ urls: [URL], center: NSPoint)
    {
        for (index,url) in urls.enumerated()
        {
            
            //1.
            if let image = NSImage(contentsOf:url)
            {
                
                var newCenter = center
                //2.
                if index > 0
                {
                    newCenter = center.addRandomNoise(Appearance.randomNoise)
                }
                
                //3.
                processImage(image, center:newCenter)
            }
        }
    }
    
    func processAction(_ action: String, center: NSPoint)
    {
        print("Process action not implemented!")    
    }
    
    func updateSceneInfoPublishReady()
    {
        OutputWriter.sharedInstance.startPublish()
        
        for child in topLayer.subviews
        {
            let imageView = child as! ExtImageView
            if imageView != nil
            {
                OutputWriter.sharedInstance.addImageView(view: imageView as! NSImageView)
            }
        }
        
        OutputWriter.sharedInstance.endPublish()
    }
}
