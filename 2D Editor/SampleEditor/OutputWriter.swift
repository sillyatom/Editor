//
//  OutputWriter.swift
//  SampleEditor
//
//  Created by Sillyatom on 25/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Foundation
import Cocoa

enum OutputKeys
{
    static let FileData:String = "FileData"
    static let BlendFunc:String = "BlendFunc"
    static let AnchorPoint:String = "AnchorPoint"
    static let Position:String = "Position"
    static let Scale:String = "Scale"
    static let CColor:String = "CColor"
    static let IconVisible:String = "IconVisible"
    static let PrePosition:String = "PrePosition"
    static let PreSize:String = "PreSize"
    static let Tag:String = "Tag"
    static let ActionTag:String = "ActionTag"
    static let Size:String = "Size"
    static let Name:String = "Name"
    static let ctype:String = "ctype"
    static let Path:String = "Path"
    static let Plist:String = "Plist"
}

class OutputWriter
{
    static var writer: OutputWriter = OutputWriter()
    private var jsonData: NSDictionary
    
    private init()
    {
        jsonData = NSDictionary()
    }
    
    var data: NSObject!
    var children:NSMutableArray!
    
    func addHeader()
    {
        jsonData.setValue("a2ee0952-26b5-49ae-8bf9-4f1d6279b798", forKey: "ID")
        jsonData.setValue("3.10.0.0", forKey: "Version")
        jsonData.setValue("MainScene", forKey: "Name")
        
        //add head content
        let hcontent:NSDictionary = NSDictionary()
        jsonData.setValue(hcontent, forKey: "Content")
        
        //add child content
        let content:NSDictionary = NSDictionary()
        hcontent.setValue(content, forKey: "Content")
        
        //add animation
        let animation:NSDictionary = NSDictionary()
        content.setValue(animation, forKey: "Animation")
        animation.setValue(0, forKey: "Duration")
        animation.setValue(1, forKey: "Speed")
        animation.setValue(NSArray(), forKey: "Timelines")
        animation.setValue("TimelineActionData", forKey: "ctype")
        
        //add animation list
        content.setValue(NSArray(), forKey: "AnimationList")
        
        //add object data
        let objectData:NSDictionary = NSDictionary()
        content.setValue(objectData, forKey: "ObjectData")
        
        //add children
        children = NSMutableArray()
        objectData.setValue(children, forKey: "Children")
        
        //add resolution size
        let size: NSDictionary = NSDictionary()
        size.setValue(960, forKey: "X")
        size.setValue(640, forKey: "Y")
        objectData.setValue(size, forKey: "Size")
        
        objectData.setValue("Scene", forKey: "Name")
        
        //add ctype
        objectData.setValue("SingleNodeObjectData", forKey: "ctype")
        
        //add used resources
        let usedResources: NSMutableArray = NSMutableArray()
        content.setValue(usedResources, forKey: "UsedResources")
        
        //add ctype
        content.setValue("GameFileData", forKey: "ctype")
        
        //add scene type
        jsonData.setValue("Scene", forKey: "Type")
    }
    
    func addImageView(view: NSImageView)
    {
        let spriteData: NSDictionary = NSDictionary()
        
        //add FileData
        let fileData: NSDictionary = NSDictionary()
        fileData.setValue("Normal", forKey: "Type")
        fileData.setValue("", forKey: OutputKeys.Path)
        fileData.setValue("", forKey: OutputKeys.Plist)
        children.setValue(fileData, forKey: OutputKeys.FileData)
        
        
    }
}
