//
//  Dispatch.swift
//  MDTable
//
//  Created by Leo on 2017/7/24.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import CoreFoundation

class Task{
    private var _task:(Void)->Void
    var taskID:String
    init(_ identifier:String,_ task:@escaping (Void)->Void){
        self._task = task
        self.taskID = identifier
    }
    func exccute(){
        _task()
    }
}
/// Dispatch Task to runloop, only one task will be executed in one runloop，use this class to handle perofrm issue
public class TaskDispatcher{
    public static let shared:TaskDispatcher = TaskDispatcher()
    var observer:CFRunLoopObserver?
    var tasks = [String:Task]()
    var taskKeys = [String]()
    init() {
        self.register()
    }
    public func add(_ identifier:String, _ block:@escaping (Void)->Void){
        let task = Task(identifier,block)
        self.add(task)
    }
    public func cancelTask(_ taskIdentifier:String){
        guard tasks[taskIdentifier] != nil else {
            return
        }
        self.tasks[taskIdentifier] = nil
        guard let index = self.taskKeys.index(of: taskIdentifier) else{
            return
        }
        self.taskKeys.remove(at: index)
    }
    func register(){
        let mainRunloop = RunLoop.main.getCFRunLoop()
        let activities = CFRunLoopActivity.beforeWaiting.rawValue | CFRunLoopActivity.exit.rawValue
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,
                                                          activities,
                                                          true,
                                                          Int.max) { (observer, activity) in
            self.executeTask()
        }
        CFRunLoopAddObserver(mainRunloop, observer, CFRunLoopMode.commonModes)
    }
    func add(_ task:Task){
        guard tasks[task.taskID] == nil else {
            return
        }
        self.tasks[task.taskID] = task
        self.taskKeys.append(task.taskID)
    }
    func executeTask(){
        guard let taskID = self.taskKeys.first else{
            return
        }
        self.taskKeys.remove(at: 0)
        guard let task = self.tasks[taskID] else{
            self.tasks[taskID] = nil
            return
        }
        self.tasks[taskID] = nil
        task.exccute()
    }
    
    func invaliate(){
        CFRunLoopRemoveObserver(RunLoop.main.getCFRunLoop(), observer, CFRunLoopMode.commonModes)
    }
}
