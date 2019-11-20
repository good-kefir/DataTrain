//
//  ISubscribtion.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

public protocol ISubscribtion{
    var name:String { get }
    var main:(IMessage)->() { get }
}
