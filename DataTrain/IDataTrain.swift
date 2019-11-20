//
//  IDataTrain.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

public protocol IDataTrain{
    
    
    func sendNow(topic:String,
                 queue:String,
                 operation: @escaping (IContext)->())
    
    func sendDeadline(deadline: DispatchTime,
                      topic:String,
                      queue:String,
                      operation: @escaping (IContext)->())
        
    
    func subscribe(topic:String,
                   queue:String,
                   handler:@escaping (IMessage)->())
}
