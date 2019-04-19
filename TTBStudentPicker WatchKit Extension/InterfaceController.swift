//
//  InterfaceController.swift
//  TTBStudentPicker WatchKit Extension
//
//  Created by Chase Hoselle on 4/17/19.
//  Copyright © 2019 Chase Hoselle. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var labelFoo: WKInterfaceLabel!
    @IBOutlet weak var indexCountLabel: WKInterfaceLabel!
    
    var nameArray = ["Chase", "Ashley", "Chad", "Ted"]
    var indexArray = [Int]()

    var index = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        refillIndexArray()
    }
    @IBAction func buttonOnClick() {
        if indexArray.count == 0 {
            refillIndexArray()
        } else {
            index = Int(arc4random_uniform(UInt32(indexArray.count)))
            labelFoo.setText(nameArray[index])
            indexArray.remove(at: index)
        }
        indexCountLabel.setText(String(index))
        print(String(indexArray.count))
        print(String(index))
    }
    
    func refillIndexArray() {
        let nameArrayCount = nameArray.count
        for n in 1...nameArrayCount {
            indexArray.append(n)
        }
        print("refillIndexArray() fired")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
