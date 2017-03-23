//
//  MainWindowController.swift
//  SampleEditor
//
//  Created by Sillyatom on 23/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController
{
    let windowWidth = 960.0
    let windowHeight = 640.0
    
    override func windowDidLoad()
    {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        let window:NSWindow = self.window!
        var frame:NSRect = window.frame
        frame.size = CGSize(width: windowWidth, height: windowHeight)
        window.setContentSize(NSSize(width: windowWidth, height: windowHeight))
        window.setFrame(frame, display: true)
    }
}
