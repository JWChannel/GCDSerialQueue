//
//  ViewController.swift
//  GCDSerialQueue
//
//  Created by J W on 2024/9/3.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func syncFromMainQueue(_ sender: Any) {
        let q = DispatchQueue(label: "fromMainQueue") // serial queue
        print("=== 1.1 === \(qos_class_main()) is main")
        print("=== 1.1 === \(qos_class_self()) is self")
        print("=== 1.1 === \(Thread.current)")
        print("=== 1.1 === \(RunLoop.current)")
        q.sync {
            print ("=== 1.2 === \(qos_class_main()) is in closure main")
            print ("=== 1.2 === \(qos_class_self()) is in closure self")
            print ("=== 1.2 === \(Thread.current)")
            print ("=== 1.2 === \(RunLoop.current)")
            print("=== 1.2.1 === q.sync from main queue")
            sleep (3)
            print("=== 1.2.2 === after q.sync from main queue")
        }
    }
    
    @IBAction func syncFromSerialQueue(_ sender: Any) {
        let q1 = DispatchQueue(label: "fromMainQueue") // serial queue
        print("=== 2.1 ===\(qos_class_main()) is in main")
        print("=== 2.1 ===\(qos_class_self()) is in self")
        print("=== 2.1 === \(Thread.current)")
        print("=== 2.1 === \(RunLoop.current)")
        q1.async {
            print("=== 2.2 ===\(qos_class_main()) is in closure main")
            print("=== 2.2 ===\(qos_class_self()) is in closure self")
            print("=== 2.2 === \(Thread.current)")
            print("=== 2.2 === \(RunLoop.current)")
            print("=== 2.2.1 === async from main queue")
            sleep (3)
            print("=== 2.2.2 === after async from main queue")
            
            let q2 = DispatchQueue(label: "fromSerialQueue") // serial queue
            q2.sync {
                print("=== 2.3 ===\(qos_class_main()) is in sync closure main")
                print("=== 2.3 ===\(qos_class_self()) is in sync closure self")
                print("=== 2.3 === \(Thread.current)")
                print("=== 2.3 === \(RunLoop.current)")
                print("=== 2.3.1 === sync from serial queue")
                sleep(3)
                print("=== 2.3.2 === after sync from serial queue")
            }
        }
    }
}

