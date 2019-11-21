//
//  IOperationQueue.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

public protocol IOperationQueue{
    
    var name:String { get }
    var subscribtions:[ISubscribtion] { get }
    
    @discardableResult
    func sendNow(operation:@escaping (IContext)->()) -> IOperationQueue
    
    
    @discardableResult
    func sendDeadline(deadline: DispatchTime,
                      operation:@escaping (IContext)->()) -> IOperationQueue
    
    @discardableResult
    func subscribe<T:AnyObject>(id:T,
                                main: @escaping (IMessage)->()) -> IOperationQueue
    
    @discardableResult
    func unsubscribe<T:AnyObject>(id:T) -> IOperationQueue
    
    @discardableResult
    func unsubscribeDeadline<T:AnyObject>(id:T,
                                          deadline: DispatchTime) -> IOperationQueue
}
