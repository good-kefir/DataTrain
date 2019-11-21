//
//  Topic.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

class Topic : ITopic{
    
    var name: String
    var queues:[String:IOperationQueue]
    private var lock:NSRecursiveLock
    
    required init(name:String){
        self.name = name
        self.queues = [:]
        lock = NSRecursiveLock()
    }
    
    func connect(queue:String) -> IOperationQueue{
        self.lock.lock()
        let queue = self.createQueueIfNeed(name: queue)
        self.lock.unlock()
        return queue
    }
        
        
    private func createQueueIfNeed(name:String) -> IOperationQueue{
        
        var queue:IOperationQueue? = self.queues[name]
        if queue == nil{
            
            queue = OperationQueue(name: name, queue: DispatchQueue(label: name))
            self.queues[name] = queue
        }
        return queue!
    }
}
