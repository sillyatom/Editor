//
//  SelectedObjects.swift
//  SampleEditor
//
//  Created by Sillyatom on 27/03/17.
//  Copyright © 2017 SillyatomGames. All rights reserved.
//

import Foundation
import Cocoa

protocol EditorObject
{
    var isHighlighted: Bool{get set}
    
    var selectionView: NSView?{get set}
    
    func getView()->NSView
    
    func updateSelectionView()
}

class SelectedEditorObject
{
    private var _obj:EditorObject!
    var editorObj: EditorObject
    {
        get
        {
            return _obj
        }
        set
        {
            _obj = newValue
        }
    }
    
    private var _offPoint: NSPoint!
    var offPoint: NSPoint
    {
        get
        {
            return _offPoint
        }
        set
        {
            _offPoint = newValue
        }
    }

    init(pObj: EditorObject?, pOffPt: NSPoint?)
    {
        if let obj = pObj
        {
            editorObj = obj
        }
        if let offPt = pOffPt
        {
            offPoint = offPt
        }
    }
}
