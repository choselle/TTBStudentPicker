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
    
    let fullNameArray = ["Chase", "Ashley", "Chad", "Ted"]
    var nameArray = [String]()

    var index = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        refillNameArray()
    }
    @IBAction func buttonOnClick() {
        if nameArray.isEmpty {
            refillNameArray()
        }
        
        index = Int(arc4random_uniform(UInt32(nameArray.count)))
        labelFoo.setText(nameArray[index])
        nameArray.remove(at: index)
        
        print(String(nameArray.count))
        print(String(index))
    }
    
    func refillNameArray() {
        nameArray = [String]()
        for n in fullNameArray {
            nameArray.append(n)
        }
        print("refillNameArray() fired")
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
