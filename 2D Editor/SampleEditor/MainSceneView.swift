//
//  MainSceneView.swift
//  SampleEditor
//
//  Created by Sillyatom on 24/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Cocoa

protocol DestinationViewDelegate
{
    func processImageURLs(_ urls: [URL], center: NSPoint)
    func processImage(_ image: NSImage, center: NSPoint)
    func processAction(_ action: String, center: NSPoint)
}

class MainSceneView: NSView
{
    var nonURLTypes: Set<String>  { return [String(kUTTypeTIFF), String(kUTTypeJPEG), String(kUTTypePNG)] }

    var acceptableTypes: Set<String> { return nonURLTypes.union([NSURLPboardType]) }
    
    var delegate: DestinationViewDelegate?
    var currentSelection: NSView!
    
    override func awakeFromNib()
    {
        //set content size
        self.frame = NSRect(x: 0.0, y: 0.0, width: 960.0, height: 640.0)
    
        //register for file types
        self.register(forDraggedTypes: Array(acceptableTypes))
    }
    
    let filteringOptions = [NSPasteboardURLReadingContentsConformToTypesKey:NSImage.imageTypes()]
    
    func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool
    {
        
        var canAccept = false
        
        //2.
        let pasteBoard = draggingInfo.draggingPasteboard()
        
        //3.
        if pasteBoard.canReadObject(forClasses: [NSURL.self], options: filteringOptions)
        {
            canAccept = true
        }
        else if let types = pasteBoard.types, nonURLTypes.intersection(types).count > 0
        {
            canAccept = true
        }

        return canAccept
        
    }
    
    var isReceivingDrag = false
    {
        didSet
        {
            needsDisplay = true
        }
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation
    {
        let allow = shouldAllowDrag(sender)
        isReceivingDrag = allow
        return allow ? .copy : NSDragOperation()
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?)
    {
        isReceivingDrag = false
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool
    {
        let allow = shouldAllowDrag(sender)
        return allow
    }
    
    override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool
    {
        //1.
        isReceivingDrag = false
        let pasteBoard = draggingInfo.draggingPasteboard()
        
        //2.
        let point = convert(draggingInfo.draggingLocation(), from: nil)
        //3.
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options:filteringOptions) as? [URL], urls.count > 0
        {
            delegate?.processImageURLs(urls, center: point)
            return true
        }
        else if let image = NSImage(pasteboard: pasteBoard)
        {
            delegate?.processImage(image, center: point)
            return true
        }
        return false
        
    }

    enum Appearance
    {
        static let lineWidth: CGFloat = 10.0
    }
    
    func checkForHighlights(mouseLocation: CGPoint?)
    {
        updateHighlights(mouseLocation: mouseLocation)
    }
    
    func updateHighlights(mouseLocation: CGPoint?)
    {
        if let point = mouseLocation
        {
            for child in subviews
            {
                if child.frame.contains(point)
                {
                    let img: ExtImageView = child as! ExtImageView
                    img.isHighlighted = true
                    currentSelection = child
                    break
                }
                else
                {
                    let img: ExtImageView = child as! ExtImageView
                    img.isHighlighted = false
                }
            }
        }
        else
        {
            for child in subviews
            {
                let img: ExtImageView = child as! ExtImageView
                img.isHighlighted = false
            }
            currentSelection = nil
        }
    }
    
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)

        // Drawing code here.
        if isReceivingDrag
        {
            NSColor.selectedControlColor.set()
            
            let path = NSBezierPath(rect:bounds)
            path.lineWidth = Appearance.lineWidth
            path.stroke()
        }
    }
    
}
