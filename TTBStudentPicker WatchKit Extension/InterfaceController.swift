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
    @IBOutlet weak var studentCountLabel: WKInterfaceLabel!
    @IBOutlet weak var buttonOutlet: WKInterfaceButton!
    
    let fullNameArray = ["Chase", "Ashley", "Chad", "Ted"]
    var nameArray = [String]()

    var index = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        refillNameArray()
        studentCountLabel.setText("Students left: " + String(nameArray.count))
    }
    @IBAction func buttonOnClick() {
        if nameArray.count == 1 {
            buttonOutlet.setTitle("Reset")
        } else {
            buttonOutlet.setTitle("Next Student")
        }
        if nameArray.isEmpty {
            refillNameArray()
        }
        
        index = Int(arc4random_uniform(UInt32(nameArray.count)))
        labelFoo.setText(nameArray[index])
        nameArray.remove(at: index)
        
        studentCountLabel.setText("Students left: " + String(nameArray.count))
        print(String(nameArray.count))
        print(String(index))
    }
    
    @IBAction func refreshButtonOnClick() {
        refillNameArray()
        labelFoo.setText("Hello!")
        studentCountLabel.setText("Students left: " + String(nameArray.count))
        buttonOutlet.setTitle("Start")
        print("Refresh Context Menu Button Clicked.")
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
