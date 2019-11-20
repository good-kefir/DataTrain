//
//  ITopic.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

public protocol ITopic : AnyObject{
    
    var name:String { get }
    
    func send(queue:String,
              operation:@escaping (IContext)->())
    
    func addSubscription(queue:String,
                         main: @escaping (IMessage)->())
}
