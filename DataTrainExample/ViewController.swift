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
        
        self.dataTrain.subscribe(topic: "1", queue: "1") { (message) in
            print(message)
        }
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + 3)
        
        
        self.dataTrain.sendNow(topic: "1", queue: "1") { (contex) in
                       print("1")
                       contex.commit(result:["1", "2"] as AnyObject)
                   }
        
        self.dataTrain.sendDeadline(deadline: .now() + 3, topic: "1", queue: "1") { (context) in
            
            print("2")
            context.commit(result:["1", "2"] as AnyObject)
        }
        
    }


}

