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
    var offPoint: NSPoint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        topLayer.delegate = self
        offPoint = NSPoint()
    }
    
    override func mouseDown(with event: NSEvent)
    {
        topLayer.checkForHighlights(mouseLocation: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        
        if let selectedChild = topLayer.currentSelection
        {
            let screenPoint: NSPoint = NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y);
            offPoint = self.view.convert(screenPoint, to: selectedChild)
        }
    }
    
    override func mouseUp(with event: NSEvent)
    {
        topLayer.checkForHighlights(mouseLocation: nil)
    }

    override func mouseDragged(with event: NSEvent)
    {
        if let selectedChild = topLayer.currentSelection
        {
            let screenPoint: NSPoint = NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y);
            let calcPoint: NSPoint = NSPoint(x: screenPoint.x - offPoint.x,
                                             y: screenPoint.y - offPoint.y)
            selectedChild.setFrameOrigin(calcPoint)
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
