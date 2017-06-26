//
//  TableManager.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

public class TableManager{
    
    public var sections:[TableSection]
    public var editorManager:TableEditor?
    public var menuManager:TableMenuManager?
    public var focusManager:TableFocusManager?
    public var tableView:UITableView?
    var delegate:TableDelegate?
    private let lock = NSRecursiveLock()
    var sectionIndexTitles:[String] = []
    var sectionIndexMap:[Int:Int] = [:]//Map index in sectionIndexTitles to section
    public init(sections:[TableSection],
                delegate:TableDelegate = TableDelegate(),
                editor:TableEditor? = nil
        ) {
        self.sections = sections
        self.delegate = delegate
        self.editorManager = editor
        self.delegate?.tableManager = self
        reloadSectionIndexTitles()
    }
    func reloadSectionIndexTitles(){
        lock.lock(); defer{lock.unlock()}
        sectionIndexTitles =  []
        sectionIndexMap =  [:]
        for (index, section) in self.sections.enumerated(){
            if let indexTitle = section.sectionIndexTitle{
                sectionIndexMap[sectionIndexTitles.count] = index
                sectionIndexTitles.append(indexTitle)
            }
        }
    }
    func bindTo(tableView:UITableView){
        self.tableView = tableView
        tableView.delegate = self.delegate
        tableView.dataSource = self.delegate
    }
    func row(at indexPath:IndexPath) -> TableRow{
        lock.lock(); defer{lock.unlock()}
        guard let row = self[indexPath] else {
            fatalError("In this method you have to make sure indexPath is valid")
        }
        return row
    }
    public func reloadData(){
        assert(tableView != nil, "You have to bind a tableView first")
        DispatchQueue.main.async {
            self.reloadSectionIndexTitles()
            self.tableView?.reloadData()
        }
    }
    open subscript(indexPath:IndexPath) -> TableRow?{
        get{
            lock.lock();defer{lock.unlock()}
            guard indexPath.section < self.sections.count else{
                return nil
            }
            var section = self.sections[indexPath.section]
            guard indexPath.row < section.rows.count else{
                return nil
            }
            return section.rows[indexPath.row]
        }
        set{
            lock.lock();defer{lock.unlock()}
            guard indexPath.section < self.sections.count else{
                return
            }
            var section = self.sections[indexPath.section]
            guard indexPath.row < section.rows.count else{
                return
            }
            if let newRow = newValue{
                section.rows[indexPath.row] = newRow
            }else{
                section.rows.remove(at: indexPath.row)
            }
        }
    }
    public func delete(row at:IndexPath){
        lock.lock();defer{lock.unlock()}
        if at.section >= self.sections.count {
            return
        }
        var section = self.sections[at.section]
        if at.row >= section.rows.count {
            return
        }
        section.rows.remove(at: at.row)
        if section.rows.count == 0 {
            sections.remove(at: at.section)
        }
    }
    
    public func delete(rows at:Set<IndexPath>){
        lock.lock();defer{lock.unlock()}
        var reducedSections = [TableSection]()
        for (sectionIndex,section) in sections.enumerated(){
            var reducedRows =  [TableRow]()
            for (rowIndex,row) in section.rows.enumerated(){
                let indexPath = IndexPath(row: rowIndex, section: sectionIndex)
                if !at.contains(indexPath){
                    reducedRows.append(row)
                }
            }
            if reducedRows.count > 0 {
                var reducedSection = section
                reducedSection.rows = reducedRows
                reducedSections.append(reducedSection)
            }
        }
        self.sections = reducedSections
    }
    
    public func insert(row content:TableRow, at indexPath:IndexPath) {
        lock.lock();defer{lock.unlock()}
        if indexPath.section >= self.sections.count {
            return
        }
        var section = self.sections[indexPath.section]
        if indexPath.row >= section.rows.count {
            return
        }
        section.rows.insert(content, at: indexPath.row)
    }
    public func exchange(_ left:IndexPath, with right:IndexPath){
        guard let leftRow = self[left], let rightRow = self[right] else {
            return
        }
        self.delete(row: left)
        self.insert(row: rightRow, at: left)
        self.delete(row: right)
        self.insert(row: leftRow, at: right)
    }
    
}
