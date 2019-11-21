//
//  ViewController.swift
//  DataTrainExample
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import UIKit
import DataTrain

class ViewController: UIViewController {
    
    let dataTrain:DataTrain = DataTrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.dataTrain.connect(name: "topic").connect(queue: "queue").sendNow { (context) in
            print("123")
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                context.commit(data: ["1", "2"] as AnyObject)
            }
            
        }.subscribe { (message) in
            print(message)
        }
        
    }
}

