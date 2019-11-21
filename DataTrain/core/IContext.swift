//
//  IContext.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 21.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

public protocol IContextDelegate : AnyObject{
    func didFinishOperation(data:AnyObject!)
}

public protocol IContext{
 
    var delegate:IContextDelegate? { get }
    
    func commit(data:AnyObject?)
}
