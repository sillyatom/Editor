//
//  ViewController.swift
//  SampleEditor
//
//  Created by Sillyatom on 16/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Cocoa

class MainVC: NSViewController
{
    var _currView: NSView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override var representedObject: Any?
    {
        didSet
        {
            // Update the view, if already loaded.
        }
    }
    
    func onSelectImgTool()
    {
        print("MainVC : On Select Tool")
        let imageView:NSImageView = NSImageView()
        
        let image: NSImage = NSImage(named: "default-thumbnail.jpg")!
        imageView.image = image
        imageView.imageAlignment = NSImageAlignment.alignBottomLeft
        
        self.view.addSubview(imageView)
        
        imageView.setFrameOrigin(NSPoint(x: 0.0, y: 0.0))
        imageView.setFrameSize(NSSize(width: 100.0, height: 100.0))
        
        let rectInScreen:NSRect = (self.view.window?.convertToScreen(imageView.frame))!
        print("\(rectInScreen.midX) \(rectInScreen.midY)")
        
        _currView = imageView
    }
    
    override func mouseDown(with event: NSEvent)
    {
        print("on mouse down! \(event.locationInWindow.x) \(event.locationInWindow.y)")
        if _currView.frame.contains(CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        {
            print("inside")
        }
        else
        {
            print("outside")
        }
    }
}

