//
//  OperationQueue.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation


class OperationQueue : IOperationQueue, IContextDelegate{
   
    private var queue:DispatchQueue
    var name:String
    var subscribtions:[ISubscribtion]
    
    lazy var context:IContext = {
        return Context(delegate: self)
    }()
    
    required init(name:String,
                  queue:DispatchQueue){
       
        self.name = name
        self.queue = queue
        self.subscribtions = []
    }
    
    @discardableResult
    func sendNow(operation:@escaping (IContext)->()) -> IOperationQueue{
        
        self.queue.async {
            operation(self.context)
        }
        return self
    }
        
 
    @discardableResult
    func sendDeadline(deadline: DispatchTime,
                      operation:@escaping (IContext)->()) -> IOperationQueue{
        
        self.queue.asyncAfter(deadline: deadline) {
            operation(self.context)
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
    
    func subscribe<T:AnyObject>(id:T,
                                main: @escaping (IMessage)->()) -> IOperationQueue{
        self.queue.async {
            
            let subscribtionName = String(describing:id.self)
            let subscribtion:ISubscribtion = Subscribtion(name: subscribtionName, main: main)
            self.subscribtions.append(subscribtion)
        }
        return self
    }
    
    @discardableResult
    func unsubscribe<T:AnyObject>(id:T) -> IOperationQueue{
        self.queue.async {
            self.removeSubscribe(id: id)
        }
        return self
    }
    
    @discardableResult
    func unsubscribeDeadline<T:AnyObject>(id:T, deadline: DispatchTime) -> IOperationQueue{
        
        self.queue.asyncAfter(deadline: deadline) {
            self.removeSubscribe(id: id)
        }
        return self
    }
    
    //MARK: IContextDelegate
    func didFinishOperation(data: AnyObject!) {
        self.notifySubscribtions(data: data)
    }
    
    private func removeSubscribe<T:AnyObject>(id:T){
        
        let subscribtionName = String(describing:id.self)
        let indexNotFount = -1
        var removeIndex:Int = indexNotFount
        for (index, subscribtion) in self.subscribtions.enumerated(){
            
            if subscribtion.name == subscribtionName{
                removeIndex = index
            }
        }
        if removeIndex != indexNotFount{
            self.subscribtions.remove(at: removeIndex)
        }
    }
    
    private func notifySubscribtions(data:AnyObject?){
        self.queue.async {
            
            for subscribtion in self.subscribtions{
                subscribtion.main(Message(id: self.name, data: data))
            }
        }
    }
}
