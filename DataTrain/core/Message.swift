//
//  Message.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

class Message : IMessage{
    var id: String
    var data:AnyObject?
    
    required init(id: String, data:AnyObject?){
        self.id = id
        self.data = data
    }
}
