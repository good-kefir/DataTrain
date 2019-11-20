//
//  Context.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

class Context : IContext{
    
    private var commitBlock:(AnyObject)->()
    
    required init(commitBlock:@escaping (AnyObject)->()){
        self.commitBlock = commitBlock
    }
    
    func commit(result: AnyObject) {
        self.commitBlock(result)
    }
}
