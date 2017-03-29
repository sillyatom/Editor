//
//  MainVC_DestinationViewDelegate.swift
//  SampleEditor
//
//  Created by Sillyatom on 28/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Foundation
import Cocoa

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
        
        let selectionView:NSView = Helper.loadViewFromNib(name: "SelectionView")!
        view.addSubview(selectionView)
        selectionView.setFrameOrigin(NSPoint(x: subview.frame.minX, y: subview.frame.maxY))
        selectionView.isHidden = true
        subview.selectionView = selectionView
        
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
