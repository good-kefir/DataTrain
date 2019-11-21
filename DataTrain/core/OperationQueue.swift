//
//  OperationQueue.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation


class OperationQueue : IOperationQueue{
    
    private var queue:DispatchQueue
    var name:String
    var subscribtions:[ISubscribtion]
    
    required init(name:String,
                  queue:DispatchQueue){
       
        self.name = name
        self.queue = queue
        self.subscribtions = []
    }
    
    @discardableResult
    func sendNow(operation:@escaping ()->(AnyObject?)) -> IOperationQueue{
        
        self.queue.async {
            let data:AnyObject? = operation()
            self.notifySubscribtions(data: data)
        }
        return self
    }
    
 
    @discardableResult
    func sendDeadline(deadline: DispatchTime,
                      operation:@escaping ()->(AnyObject?)) -> IOperationQueue{
        
        self.queue.asyncAfter(deadline: deadline) {
            let data:AnyObject? = operation()
            self.notifySubscribtions(data: data)
        }
        return self
    }
    
    @discardableResult
    func subscribe(main: @escaping (IMessage)->()) -> IOperationQueue{
        
        self.queue.async {
            let subscribtion:ISubscribtion = Subscribtion(name: self.name, main: main)
            self.subscribtions.append(subscribtion)
        }
        return self
    }
    
    private func notifySubscribtions(data:AnyObject?){
        self.queue.async {
            
            for subscribtion in self.subscribtions{
                subscribtion.main(Message(id: self.name, data: data))
            }
        }
    }
}
