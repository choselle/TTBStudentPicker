//
//  InterfaceController.swift
//  TTBStudentPicker WatchKit Extension
//
//  Created by Chase Hoselle on 4/17/19.
//  Copyright © 2019 Chase Hoselle. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // 1: Session property
    var session : WCSession?
    
    // Second View Controller
    @IBOutlet weak var labelFoo: WKInterfaceLabel!
    @IBOutlet weak var studentCountLabel: WKInterfaceLabel!
    @IBOutlet weak var studentPickerButtonOutlet: WKInterfaceButton!
    @IBOutlet weak var buttonOnClickOutlet: WKInterfaceButton!
    
    var classAArray = [String]()
    let classBArray = ["Ted", "Sean", "Jordan", "Kenny", "Zach"]
    var nameArray = [String]()

    var index = 0
    var currentClass = 1
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
        
        // Configure interface objects here.
        print("CurrentClass" + String(currentClass))
        print(classAArray)
        refillNameArray(classNumber: currentClass)
        //studentCountLabel.setText("Students left: " + String(nameArray.count))
    }
    
    
    @IBAction func refreshButtonOnClick() {
        refillNameArray(classNumber: currentClass)
        labelFoo.setText("Hello!")
        studentCountLabel.setText("Students left: " + String(nameArray.count))
        buttonOnClickOutlet.setTitle("Start")
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
        
        // 2: Initialization of session and set as delegate this InterfaceController
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func sendMessage() {
        print(classAArray)
    }
    
    @IBAction func buttonOnClick() {
        print(classAArray)
        if nameArray.count == 1 {
            buttonOnClickOutlet.setTitle("Reset")
        } else {
            buttonOnClickOutlet.setTitle("Next Student")
        }
        if nameArray.isEmpty {
            refillNameArray(classNumber: currentClass)
        }
        
        index = Int(arc4random_uniform(UInt32(nameArray.count)))
        labelFoo.setText(nameArray[index])
        nameArray.remove(at: index)
        
        studentCountLabel.setText("Students left: " + String(nameArray.count))
    }
    
    // 4: Required stub for delegating session
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
        if (session.isReachable) {
            session.sendMessage(["request" : "version"], replyHandler: { (response) in
                let foobar = response["version"] as! [String]
                self.classAArray = foobar
                print(self.classAArray)
                self.buttonOnClickOutlet.setEnabled(true)
            }, errorHandler: { (error) in
                print("Error sending message: %@", error)
            })
        } else {
            print("iPhone is not reachable!!")
        }
    }
}
