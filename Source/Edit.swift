//
//  EditTable.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

public protocol EditableRow {
    var titleForDeleteConfirmationButton:String? {get}
    var editingStyle:UITableViewCellEditingStyle {get}
    var canMove:Bool{ get }

    //These are optional
    var shouldIndentWhileEditing:Bool { get }
    var canEdit:Bool {get}
    var editActionsForRowAt:(UITableView, IndexPath)->[UITableViewRowAction]? {get}
}

extension EditableRow{
    public var shouldIndentWhileEditing:Bool {return true}
    public var canEdit:Bool { return true}
    public var canMove:Bool{ return false }
    public var editActionsForRowAt:(UITableView, IndexPath)->[UITableViewRowAction]? {
        return {  (_,_) in
            return nil
        }
    }
}

public protocol Editor{
    var editingStyleCommitForRowAt:(UITableView,UITableViewCellEditingStyle,IndexPath)->Void {get}
    
    //These are optional
    var moveRowAtSourceIndexPathToDestinationIndexPath:(UITableView, IndexPath, IndexPath)->Void{ get }
    var targetIndexPathForMoveFromTotoProposedIndexPath:(UITableView, IndexPath, IndexPath) ->IndexPath {get}
    var willBeginEditingRowAt:(UITableView, IndexPath) -> Void {get}
    var didEndEditingRowAt:(UITableView, IndexPath?) -> Void {get}
}

extension Editor{
    public var willBeginEditingRowAt:(UITableView, IndexPath) -> Void{
        return {(_,_) in}
    }
    public var didEndEditingRowAt:(UITableView, IndexPath?) -> Void{
        return {(_,_) in}
    }
    public var targetIndexPathForMoveFromTotoProposedIndexPath:(UITableView, IndexPath, IndexPath) ->IndexPath{
        return {(_,_,proposedDestinationIndexPath) in
            return proposedDestinationIndexPath;
        }
    }
    public var moveRowAtSourceIndexPathToDestinationIndexPath:(UITableView, IndexPath, IndexPath) ->Void{
        return {(_,_,proposedDestinationIndexPath) in }
    }
}


open class TableEditor:Editor{
    public var editingStyleCommitForRowAt: (UITableView, UITableViewCellEditingStyle, IndexPath) -> Void
    public var willBeginEditingRowAt:(UITableView, IndexPath) -> Void
    public var didEndEditingRowAt:(UITableView, IndexPath?) -> Void
    public var moveRowAtSourceIndexPathToDestinationIndexPath:(UITableView, IndexPath, IndexPath)->Void
    public init(){
        editingStyleCommitForRowAt = { (_,_,_) in}
        moveRowAtSourceIndexPathToDestinationIndexPath = { (_,_,_) in}
        willBeginEditingRowAt = {(_,_) in}
        didEndEditingRowAt = {(_,_) in}
    }
}
