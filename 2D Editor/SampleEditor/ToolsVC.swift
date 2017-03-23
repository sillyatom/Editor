//
//  ToolsVC.swift
//  SampleEditor
//
//  Created by Sillyatom on 17/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Cocoa

class ToolsVC: NSViewController
{

    @IBOutlet weak var imgComponent: NSButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func OnSelectImgTool(_ sender: NSButton)
    {
        print("ToolsVC : On Select Image Tool");
        let window:NSWindow = NSApplication.shared().windows.first!
        let mainWindowController:MainWindowController = window.windowController! as! MainWindowController
        let mainVC:MainVC = mainWindowController.contentViewController as! MainVC
        mainVC.onSelectImgTool()
    }
}
