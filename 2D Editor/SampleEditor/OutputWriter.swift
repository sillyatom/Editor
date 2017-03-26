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

    private var jsonData: Dictionary<String, AnyObject>!
    static var sharedInstance: OutputWriter = OutputWriter()
    
    private init()
    {
        
    }
    
    var data: NSObject!
    var children:NSMutableArray!
    var content: Dictionary<String, AnyObject>!;
    var objectData: Dictionary<String, AnyObject>!
    
    func startPublish()
    {
        jsonData = Dictionary<String, AnyObject>()
        addHeader()
    }
    
    func endPublish()
    {
        objectData.updateValue(children as AnyObject, forKey: "Children")
        content.updateValue(objectData as AnyObject, forKey: "ObjectData")
        jsonData.updateValue(content as AnyObject, forKey: "Content")
    }
    
    private func addHeader()
    {
        jsonData.updateValue("1.0" as AnyObject, forKey: "Version")
        
        //TODO : get this from filename
        jsonData.updateValue("MainScene" as AnyObject, forKey: "Name")
        
        //add child content
        content = Dictionary<String, AnyObject>()
        
        //add object data
        objectData = Dictionary<String, AnyObject>()
        
        //add children
        children = NSMutableArray()
        
        //add resolution size
        var size: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        //TODO : get this from document
        size.updateValue(960 as AnyObject, forKey: "ResX")
        size.updateValue(640 as AnyObject, forKey: "ResY")
        objectData.updateValue(size as AnyObject, forKey: "ResolutionSize")
        
        objectData.updateValue("Scene" as AnyObject, forKey: "Name")
        
        //add ctype
        objectData.updateValue("SingleNodeObjectData" as AnyObject, forKey: "ctype")
        
        //add used resources
        let usedResources: NSMutableArray = NSMutableArray()
        content.updateValue(usedResources as AnyObject, forKey: "UsedResources")
        
        //add ctype
        content.updateValue("GameFileData" as AnyObject, forKey: "ctype")
        
        //add scene type
        jsonData.updateValue("Scene" as AnyObject, forKey: "Type")
        
        jsonData.updateValue(content as AnyObject, forKey: "Content")
    }
    
    func addImageView(view: NSImageView)
    {
        var spriteData: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        //add FileData
        var fileData: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        fileData.updateValue("Normal" as AnyObject, forKey: "Type")
        
        //TODO get this info from image
        //
        fileData.updateValue("" as AnyObject, forKey: OutputKeys.Path)
        spriteData.updateValue(fileData as AnyObject, forKey: OutputKeys.FileData)
        
        //add position
        var position:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        position.updateValue(view.frame.midX as AnyObject, forKey: "X")
        position.updateValue(view.frame.midY as AnyObject, forKey: "Y")
        spriteData.updateValue(position as AnyObject, forKey: "Position")
        
        self.children.add(spriteData)
    }
    
    func getDataToSave()->Data?
    {
        var data: Data?;
        do
        {
            data = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        return data
    }
}
