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
    
    // Second View Controller
    @IBOutlet weak var labelFoo: WKInterfaceLabel!
    @IBOutlet weak var studentCountLabel: WKInterfaceLabel!
    @IBOutlet weak var buttonOutlet: WKInterfaceButton!
    
    let classAArray = ["Chase", "Ashley", "Chad", "Gwen", "Steve"]
    let classBArray = ["Ted", "Sean", "Jordan", "Kenny", "Zach"]
    var nameArray = [String]()

    var index = 0
    var currentClass = 1
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        print("CurrentClass" + String(currentClass))
        refillNameArray(classNumber: currentClass)
        //studentCountLabel.setText("Students left: " + String(nameArray.count))
    }
    @IBAction func buttonOnClick() {
        if nameArray.count == 1 {
            buttonOutlet.setTitle("Reset")
        } else {
            buttonOutlet.setTitle("Next Student")
        }
        if nameArray.isEmpty {
            refillNameArray(classNumber: currentClass)
        }
        
        index = Int(arc4random_uniform(UInt32(nameArray.count)))
        labelFoo.setText(nameArray[index])
        nameArray.remove(at: index)
        
        studentCountLabel.setText("Students left: " + String(nameArray.count))
    }
    
    @IBAction func refreshButtonOnClick() {
        refillNameArray(classNumber: currentClass)
        labelFoo.setText("Hello!")
        studentCountLabel.setText("Students left: " + String(nameArray.count))
        buttonOutlet.setTitle("Start")
    }
    
    @IBAction func ClassAContextMenuPressed() {
        print("Class A Context Menu Button Pressed")
        currentClass = 1
        refreshButtonOnClick()
    }
    
    @IBAction func ClassBContextMenuPressed() {
        print("Class B Context Menu Button Pressed")
        currentClass = 2
        refreshButtonOnClick()
    }
    
    func refillNameArray(classNumber: Int) {
        nameArray = [String]()
        if (classNumber == 1) {
            print("class number 1")
            for n in classAArray {
                nameArray.append(n)
            }
        } else if (classNumber == 2) {
            print("class number 2")
            for n in classBArray {
                nameArray.append(n)
            }
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
