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
    
    func onSelectTool()
    {
        print("MainVC : On Select Tool")
        var imageView:NSImageView!
        imageView = NSImageView()
        let image: NSImage = NSImage(named: "default-thumbnail.jpg")!
        imageView.image = image
        imageView.imageAlignment = NSImageAlignment.alignCenter
        imageView.setFrameSize(NSSize(width: 100.0, height: 100.0))
        self.view.addSubview(imageView)
    }
}

