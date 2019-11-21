//
//  Context.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 21.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

class Context : IContext{
   
    weak var delegate:IContextDelegate?
    
    required init(delegate:IContextDelegate){
        self.delegate = delegate
    }
    
    func commit(data: AnyObject?) {
        self.delegate?.didFinishOperation(data: data)
    }
}
