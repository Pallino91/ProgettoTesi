//
//  ViewControllerChoise.swift
//  ProgettoTesi
//
//  Created by mgonline on 25/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import UIKit

class ViewControllerChoise: UIViewController {
    var dangerMask : String = "Face Mask Detection"
    var dangerCorona : String = "Coronavirus"
    var dangerTask : String = "Task safaty"
    var dangerCrowding : String = "Crowding"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func choiseMask(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BottonMask", sender: nil)
    }
    
    @IBAction func choiseCorona(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BottonCorona", sender: nil)
    }
    @IBAction func choiseTaskSafety(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BottonTask", sender: nil)
    }
    @IBAction func choiseCrowding(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BottonCrowding", sender: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != nil else{return}
        switch segue.identifier {
        case "BottonMask":
            (segue.destination as! ViewController).labelRiskReceived = dangerMask
            (segue.destination as! ViewController).choiseType = "Mask"
        case "BottonCorona":
            (segue.destination as! ViewController).labelRiskReceived = dangerCorona
            (segue.destination as! ViewController).choiseType = "Coronavirus"
        case "BottonTask":
            (segue.destination as! ViewController).labelRiskReceived = dangerTask
            (segue.destination as! ViewController).choiseType = "Task-safety"
        case "BottonCrowding":
            (segue.destination as! ViewController).labelRiskReceived = dangerCrowding
            (segue.destination as! ViewController).choiseType = "Crowding"
        default:
            break
        }
    }
}
