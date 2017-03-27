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
    var currentSelection: NSMutableArray!
    
    override func awakeFromNib()
    {
        self.wantsLayer = true
        
        //set content size
        self.frame = NSRect(x: 0.0, y: 0.0, width: 960.0, height: 640.0)
    
        //register for file types
        self.register(forDraggedTypes: Array(acceptableTypes))
        
        currentSelection = NSMutableArray()
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
            currentSelection.removeAllObjects()
            for child in subviews
            {
                if child.frame.contains(point)
                {
                    if child is EditorObject
                    {
                        var img: EditorObject = child as! EditorObject
                        img.isHighlighted = true
                        currentSelection.add(SelectedEditorObject(pObj: img, pOffPt: nil))
                    }
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
            currentSelection.removeAllObjects()
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
    
    
    //For selection /
    
    var startPoint : NSPoint!
    var shapeLayer : CAShapeLayer!
    var shapeRect : NSRect!
    
    func startSelection(with event: NSEvent)
    {
        self.startPoint = self.convert(event.locationInWindow, from: nil)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = NSColor.clear.cgColor
        shapeLayer.strokeColor = NSColor.black.cgColor
        shapeLayer.lineDashPattern = [10,5]
        self.layer?.addSublayer(shapeLayer)
        
        var dashAnimation = CABasicAnimation()
        dashAnimation = CABasicAnimation(keyPath: "lineDashPhase")
        dashAnimation.duration = 0.75
        dashAnimation.fromValue = 0.0
        dashAnimation.toValue = 15.0
        dashAnimation.repeatCount = .infinity
        shapeLayer.add(dashAnimation, forKey: "linePhase")
        
    }
    
    func dragSelection(with event: NSEvent)
    {
        
        let point : NSPoint = self.convert(event.locationInWindow, from: nil)
        let path = CGMutablePath()
        path.move(to: self.startPoint)
        path.addLine(to: NSPoint(x: self.startPoint.x, y: point.y))
        path.addLine(to: point)
        path.addLine(to: NSPoint(x:point.x,y:self.startPoint.y))
        path.closeSubpath()
        self.shapeLayer.path = path
        
        self.shapeRect = NSRect.init(x: self.startPoint.x, y: self.startPoint.y, width: point.x - self.startPoint.x, height: point.y - self.startPoint.y)
    }
    
    func endSelection(with event: NSEvent)
    {
        if let rect = self.shapeRect
        {
            currentSelection.removeAllObjects()
            for child in subviews
            {
                if rect.intersects(child.frame)
                {
                    if child is EditorObject
                    {
                        var img: EditorObject = child as! EditorObject
                        img.isHighlighted = true
                        currentSelection.add(SelectedEditorObject(pObj: img, pOffPt: nil))
                    }
                    else
                    {
                        var img: EditorObject = child as! EditorObject
                        img.isHighlighted = false
                    }
                }
            }
        }
        
        if let shape = self.shapeLayer
        {
            shape.removeFromSuperlayer()
        }
        
        self.shapeLayer = nil
        self.shapeRect = nil
    }
}
