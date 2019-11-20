//
//  IMessage.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

public protocol IMessage : AnyObject{
    var id:String { get }
    var data:AnyObject? { get }
}
