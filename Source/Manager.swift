//
//  TableManager.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

public class TableManager{
    
    public var sections:[SectionConvertable]
    public var editorManager:Editor?
    public var menuManager:TableMenuManager?
    public var focusManager:TableFocusManager?
    var dispatcher:TaskDispatcher = TaskDispatcher(mode: .default)
    public weak var tableView:UITableView?
    var delegate:TableDelegate?
    private let lock = NSRecursiveLock()
    var sectionIndexTitles:[String] = []
    var sectionIndexMap:[Int:Int] = [:]//Map index in sectionIndexTitles to section
    lazy var preloader:TablePreloader = TablePreloader()
    public init(sections:[SectionConvertable],
                delegate:TableDelegate = TableDelegate(),
                editor:Editor? = nil
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
        //Preload Sections
        DispatchQueue.global(qos: .userInteractive).async {
            self.dispatcher.reset()
            self.sections.forEach { (section) in
                if let _section = section as? PreloadableSection{
                    let rows = _section.preloadRows
                    rows.forEach({ (row) in
                        self.dispatcher.add(row.reuseIdentifier, {
                            self.preloader.preload(row, tableView: tableView)
                        })
                    })
                }
            }
        }
    }
    func row(at indexPath:IndexPath) -> RowConvertable{
        lock.lock(); defer{lock.unlock()}
        guard let row = self[indexPath] else {
            fatalError("In this method you have to make sure indexPath is valid")
        }
        return row
    }
    public func reloadData(){
        assert(tableView != nil, "You have to bind a tableView first")
        asyncExecuteOnMain {
            self.reloadSectionIndexTitles()
            self.tableView?.reloadData()
        }
    }
    open subscript(indexPath:IndexPath) -> RowConvertable?{
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
    @discardableResult
    public func delete(row at:IndexPath) -> RowConvertable?{
        lock.lock();defer{lock.unlock()}
        if at.section >= self.sections.count {
            return nil
        }
        var section = self.sections[at.section]
        if at.row >= section.rows.count {
            return nil
        }
        let row = section.rows.remove(at: at.row)
        if section.rows.count == 0 {
            sections.remove(at: at.section)
        }
        return row
    }
    public func move(from indexPath:IndexPath, to destinationIndexPath:IndexPath ){
        guard let row = self.delete(row: indexPath) else{
            return
        }
        self.insert(row: row, at: destinationIndexPath)
    }
    
    public func delete(rows at:Set<IndexPath>){
        lock.lock();defer{lock.unlock()}
        var reducedSections = [SectionConvertable]()
        for (sectionIndex,section) in sections.enumerated(){
            var reducedRows =  [RowConvertable]()
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
    
    public func insert(row content:RowConvertable, at indexPath:IndexPath) {
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
}
