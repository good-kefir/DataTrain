//
//  Operation.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

enum  OperationState {
    case new
    case process
    case finished
}

class Operation : IOperation{
    var main:(IContext)->()
    var state:OperationState
    var context:IContext
    
    required init(main:@escaping (IContext)->(),
                  context:IContext,
                  state:OperationState = .new){
        
        self.main = main
        self.state = state
        self.context = context
    }
    
    func run(){
        self.state = .process
        self.main(self.context)
        self.state = .finished
    }
}
