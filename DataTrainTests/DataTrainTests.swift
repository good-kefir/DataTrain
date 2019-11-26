//
//  DataTrainTests.swift
//  DataTrainTests
//
//  Created by Alexey Ivankov on 20.11.2019.
//  Copyright © 2019 ivankov. All rights reserved.
//

import XCTest
@testable import DataTrain

class DataTrainTests: XCTestCase {

    var dataTrain:IDataTrain = DataTrain()
    
    override func setUp() {
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateTopicsAndQueues(){
        
        for index in 0...100{
            let topic = self.dataTrain.connect(name: String(index))
            XCTAssert(topic.name == String(index))
            
            for index in 0...100{
                let queue = topic.connect(queue: String(index))
                XCTAssert(queue.name == String(index))
            }
        }
    }
    
    func testAddSynchOperations(){
        
        let expectation = XCTestExpectation(description: "expectation")
        
        let topic = self.dataTrain.connect(name: "topic")
        let queue = topic.connect(queue: "queue")
        let countOperations:Int = 1000
        
        for index in 0...countOperations{
            queue.sendNow { (context) in
                print(index)
                context.commit(data: index as AnyObject)
            }.subscribe(id: self) { (message) in
                let index = message.data as! Int
                if index == countOperations{
                    expectation.fulfill()
                }
            }
        }
         wait(for: [expectation], timeout: 20.0)
    }
    
    func testAddAsynchOperations(){
           
           let expectation = XCTestExpectation(description: "expectation")
           
           let topic = self.dataTrain.connect(name: "topic")
           let queue = topic.connect(queue: "queue")
           let countOperations:Int = 100
           
           for index in 0...countOperations{
               queue.sendNow { (context) in
                   print(index)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                     context.commit(data: index as AnyObject)
                }
                  
               }.subscribe(id: self) { (message) in
                   let index = message.data as! Int
                   if index == countOperations{
                       expectation.fulfill()
                   }
               }
           }
            wait(for: [expectation], timeout: 20.0)
       }
    
    func testAddOperationsMultithreading() {
        
        let expectation = XCTestExpectation(description: "expectation")
        
        for index in 0...100{
            
            let topic = self.dataTrain.connect(name: String(index))
            let queue = topic.connect(queue: String(index))
            
            DispatchQueue.global().async {
                           queue.subscribe(id: self) { (message) in
                            let index = message.data as! Int
                            print("topic name = \(topic.name), thread = \(Thread.current.description), receive index \(index)")
                           }
                       }
            
            for _ in 0...100{
                DispatchQueue.global().async {
                    queue.sendNow { (contex) in
                        
                        print("send index \(index), topic name = \(topic.name), thread = \(Thread.current.description)")
                        contex.commit(data: index as AnyObject)
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 15)
    }
    
    func testNotify(){
        
        let topic = self.dataTrain.connect(name: "topic")
        let queue = topic.connect(queue: "queue")
        
        queue.subscribe(id: self) { (message) in
            print(message)
        }.notify()
        
        queue.subscribe(id: self) { (message) in
            print(message)
        }.notifyDeadline(deadline: .now() + 2)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
