//
//  ITopicItem.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

public protocol ITopicItem{
    
    var name:String { get }
    var subscribtions:[ISubscribtion] { get }
    var context:IContext { get }
    var queue:DispatchQueue { get }
    
    func send(operation:@escaping (IContext)->())
    func add(subscription:ISubscribtion)
}
