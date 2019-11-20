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
    var items:[String:ITopicItem]
    
    required init(name:String){
        self.name = name
        self.items = [:]
    }
        
    func sendNow(queue:String,
                 operation:@escaping (IContext)->()){
        
        let item = self.createItemIfNeed(name: queue)
        item.sendNow(operation: operation)
    }
    
    func sendDeadline(deadline: DispatchTime,
                      queue:String,
                      operation:@escaping (IContext)->()){
        let item = self.createItemIfNeed(name: queue)
        item.sendDeadline(deadline:deadline, operation: operation)
    }
        
    func addSubscription(queue:String,
                         main: @escaping (IMessage)->()){
        
        let item = self.createItemIfNeed(name: queue)
        let subscribtion:ISubscribtion = Subscribtion(name: queue, main: main)
        item.add(subscription: subscribtion)
        
    }
    
    private func createItemIfNeed(name:String) -> ITopicItem{
        
        var item:ITopicItem? = self.items[name]
        if item == nil{
            item = TopicItem(name: name, queue: DispatchQueue(label: name))
            self.items[name] = item
        }
        return item!
    }
}
