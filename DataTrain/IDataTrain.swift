//
//  IDataTrain.swift
//  DataTrain
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import Foundation

public protocol IDataTrain{
    
    func connect(name:String) -> ITopic
}
