//
//  TableManager.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

public class TableDelegate: NSObject, UITableViewDataSource,UITableViewDelegate{
    weak var tableManager:TableManager!
// MARK: - Common Delegate Method
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableManager.row(at: indexPath)
        return row.cellForRowAt(tableView, indexPath)
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableManager.sections.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableManager.sections[section].rows.count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableManager.row(at: indexPath).rowHeight
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = tableManager.row(at: indexPath)
        return row.estimatedHeighAt(tableView,indexPath)
    }
    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        let row = tableManager.row(at: indexPath)
        return row.indentationLevelForRowAt(tableView, indexPath)
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = tableManager.row(at: indexPath)
        return row.didEndDisplaying(tableView, cell, indexPath)
    }
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = tableManager.row(at: indexPath)
        return row.didEndDisplaying(tableView, cell, indexPath)
    }
    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let row = tableManager.row(at: indexPath)
        return row.accessoryButtonTappedForRowWith(tableView, indexPath)
    }
    // MARK: - Select
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let row = tableManager.row(at: indexPath)
        return row.willSelectedRowAt(tableView,indexPath)
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tableManager.row(at: indexPath)
        row.didSelectRowAt(tableView,indexPath)
    }
    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let row = tableManager.row(at: indexPath)
        return row.willDeselectedRowAt(tableView,indexPath)
    }
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let row = tableManager.row(at: indexPath)
        return row.didDeselectRowAt(tableView,indexPath)
    }
// MARK: - Highlight
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let row = tableManager.row(at: indexPath)
        return row.shouldHighlight
    }
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let row = tableManager.row(at: indexPath)
        row.didHighlightRowAt(tableView, indexPath)
    }
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let row = tableManager.row(at: indexPath)
        row.didUnhighlightRowAt(tableView, indexPath)
    }
    
// MARK: - Header
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sec = tableManager.sections[section]
        return sec.titleForHeader
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sec = tableManager.sections[section]
        return sec.viewForHeader
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sec = tableManager.sections[section]
        return sec.heightForHeader
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let sec = tableManager.sections[section]
        return sec.estimatedHeightForHeader
    }
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let sec = tableManager.sections[section]
        sec.willDisplayHeaderView(tableView,view,section)
    }
    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        let sec = tableManager.sections[section]
        sec.didEndDisplayingHeaderView(tableView,view,section)
    }
// MARK: - Footer
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let sec = tableManager.sections[section]
        return sec.titleForFooter
    }
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let sec = tableManager.sections[section]
        sec.willDisplayFooterView(tableView,view,section)
    }
    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        let sec = tableManager.sections[section]
        sec.didEndDisplayingFooterView(tableView,view,section)
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sec = tableManager.sections[section]
        return sec.viewForFooter
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sec = tableManager.sections[section]
        return sec.heightForFooter
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let sec = tableManager.sections[section]
        return sec.estimatedHeightForFooter
    }
    
// MARK: - Editing
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let row = tableManager.row(at: indexPath)
        if let editableRow = row as? EditableRow{
            return editableRow.editActionsForRowAt(tableView, indexPath)
        }
        return nil
    }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        tableManager.editorManager?.editingStyleCommitForRowAt(tableView, editingStyle, indexPath)
    }
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        let row = tableManager.row(at: indexPath)
        if let editableRow = row as? EditableRow{
            return editableRow.titleForDeleteConfirmationButton
        }
        return nil
    }
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let row = tableManager.row(at: indexPath)
        if let editableRow = row as? EditableRow{
            return editableRow.canEdit
        }
        return false
    }
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let row = tableManager.row(at: indexPath)
        if let moveableRow = row as? EditableRow{
            return moveableRow.canMove
        }
        return false
    }
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tableManager.editorManager?.moveRowAtSourceIndexPathToDestinationIndexPath(tableView,sourceIndexPath,destinationIndexPath)
    }
    
    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        tableManager.editorManager?.willBeginEditingRowAt(tableView, indexPath)
    }
    public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        tableManager.editorManager?.didEndEditingRowAt(tableView, indexPath)
    }
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let row = tableManager.row(at: indexPath)
        if let editableRow = row as? EditableRow{
            return editableRow.editingStyle
        }
        return .none
    }
    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        let row = tableManager.row(at: indexPath)
        if let editableRow = row as? EditableRow{
            return editableRow.shouldIndentWhileEditing
        }
        return false
    }
    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if let tableEditor = tableManager.editorManager {
            return tableEditor.targetIndexPathForMoveFromTotoProposedIndexPath(tableView, sourceIndexPath, proposedDestinationIndexPath)
        }
        return proposedDestinationIndexPath
    }
    
// MARK: - IndexTitle
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard tableManager.sectionIndexTitles.count > 0 else {
            return nil
        }
        return tableManager.sectionIndexTitles
    }
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let section = tableManager.sectionIndexMap[index] else{
            return 0
        }
        return section
    }
    
// MARK: - Copy/Paste
    public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        guard let menuManager = tableManager.menuManager else{
            return false
        }
        return menuManager.tableView(tableView, shouldShowMenuForRowAt: indexPath)
    }
    public func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        guard let menuManager = tableManager.menuManager else{
            return false
        }
        return menuManager.tableView(tableView, canPerformAction: action, forRowAt: indexPath, withSender: sender)
    }
    public func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        tableManager.menuManager?.tableView(tableView, performAction: action, forRowAt: indexPath, withSender: sender)
    }
// MARK: - Focus
    public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        guard let focusManager = tableManager.focusManager else {
            return false
        }
        return focusManager.tableView(tableView,canFocusRowAt:indexPath)
    }
    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        guard let focusManager = tableManager.focusManager else {
            return false
        }
        return focusManager.tableView(tableView,shouldUpdateFocusIn:context)
    }
    @available(iOS 9.0, *)
    public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        tableManager.focusManager?.tableView(tableView, didUpdateFocusIn: context, with: coordinator)
    }
    public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        return tableManager.focusManager?.indexPathForPreferredFocusedView(in: tableView)
    }
}

