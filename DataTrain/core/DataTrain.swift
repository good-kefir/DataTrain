//
//  DataTrain.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

public class DataTrain : IDataTrain{
    
 
    private var topics:[String:ITopic]
    private var workQueue:DispatchQueue
    
    required public init(){
        topics = [:]
        workQueue = DispatchQueue(label: "Broker")
    }
    
    public func sendNow(topic: String,
                        queue: String,
                        operation: @escaping (IContext) -> ()){
            
            self.addThreadSaveOperation {
                    let topic = self.createIfNeedTopic(nameTopic: topic)
                    topic.sendNow(queue: queue, operation: operation)
            }
     }
    
    public func sendDeadline(deadline: DispatchTime,
                             topic:String,
                             queue:String,
                             operation: @escaping (IContext)->()){
        
        self.addThreadSaveOperation {
            let topic = self.createIfNeedTopic(nameTopic: topic)
            topic.sendDeadline(deadline:deadline, queue: queue, operation: operation)
        }
        
    }
     
     public func subscribe(topic: String,
                    queue: String,
                    handler: @escaping (IMessage) -> ()){
        
        self.addThreadSaveOperation {
                   let topic = self.createIfNeedTopic(nameTopic: topic)
                   topic.addSubscription(queue: queue, main: handler)
               }
     }
    
    
    private func createIfNeedTopic(nameTopic:String) -> ITopic{
         
        var topic:ITopic? = self.topics[nameTopic]
        if topic == nil{
            topic = Topic(name: nameTopic)
            self.topics[nameTopic] = topic
        }
        
        return topic!
     }
    

    private func addThreadSaveOperation(block:@escaping ()->Void)
    {
        self.workQueue.async {
            block()
        }
    }
    
}
