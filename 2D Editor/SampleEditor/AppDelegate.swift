//
//  AppDelegate.swift
//  SampleEditor
//
//  Created by Sillyatom on 16/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    var writer:OutputWriter!;
    
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        // Insert code here to initialize your application
        writer = OutputWriter.sharedInstance
    }

    func applicationWillTerminate(_ aNotification: Notification)
    {
        // Insert code here to tear down your application
    }

    @IBAction func publish(sender: AnyObject)
    {
        let window:NSWindow = NSApplication.shared().windows.first!
        let mainWindowController:MainWindowController = window.windowController! as! MainWindowController
        let mainVC:MainVC = mainWindowController.contentViewController as! MainVC
        mainVC.updateSceneInfoPublishReady()

        let savePanel = NSSavePanel()
        
        savePanel.begin
            { (result) in
                if result == NSFileHandlingPanelOKButton
                {
                    let url = savePanel.url
                    let dataStr:String = String(data: self.writer.getDataToSave()!, encoding: .utf8)!
                    do
                    {
                        try dataStr.write(to: url!, atomically: true, encoding: String.Encoding.utf8)
                    }
                    catch
                    {
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

