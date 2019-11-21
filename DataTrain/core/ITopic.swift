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
    func connect(queue:String) -> IOperationQueue
}
