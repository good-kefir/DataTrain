//
//  Subscribtion.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

class Subscribtion : ISubscribtion{
    
    let name:String
    let main:(IMessage)->()
    
    required init(name:String,
                  main: @escaping (IMessage)->()){
        
        self.name = name
        self.main = main
    }
}
