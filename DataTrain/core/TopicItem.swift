//
//  TopicItem.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

class TopicItem : ITopicItem{
    
    var name: String
    var subscribtions: [ISubscribtion]
    var queue: DispatchQueue
    
    lazy var context: IContext = {
         return Context { (data) in
             self.notifySubscribtiptions(data: data)
         }
     }()
    
    required init(name:String,
                  queue:DispatchQueue){
        self.name = name
        self.subscribtions = []
        self.queue = queue
    }
    
    public func send(operation:@escaping (IContext)->()){
        self.queue.async {
            operation(self.context)
        }
    }
    
    public func add(subscription: ISubscribtion) {
        self.queue.async {
             self.subscribtions.append(subscription)
        }
    }
    
    private func notifySubscribtiptions(data:AnyObject){
        self.queue.async {
            for subscription in self.subscribtions{
                subscription.main(Message(id: "", data: data))
            }
        }
    }
}
