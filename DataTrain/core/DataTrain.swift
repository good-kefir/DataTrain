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
    private var lock:NSRecursiveLock
    
    required public init(){
        topics = [:]
        lock = NSRecursiveLock()
    }
    
    public func connect(name:String) -> ITopic{
        self.lock.lock()
        let topic = self.createIfNeedTopic(nameTopic: name)
        self.lock.unlock()
        return topic
    }
    

    private func createIfNeedTopic(nameTopic:String) -> ITopic{
         
        var topic:ITopic? = self.topics[nameTopic]
        if topic == nil{
            topic = Topic(name: nameTopic)
            self.topics[nameTopic] = topic
        }
        
        return topic!
     }
    
}
