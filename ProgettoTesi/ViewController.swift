//
//  ViewController.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelTypeRisk: UILabel!
    @IBOutlet weak var labelTimerText: UILabel!
    @IBOutlet weak var imgInizio: UIImageView!
    var choiseType : String = ""
    var labelRiskReceived = ""
    var resulLanding : LandingResponse?
    var seconds : Double = 0.0
    var timer = Timer()
    var f = 1
    var status : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgInizio.layer.cornerRadius = 90
        imgInizio.layer.borderWidth = 3
        imgInizio.layer.masksToBounds = true
        self.labelTypeRisk.text = labelRiskReceived
        print(labelTypeRisk.text!)
        print(choiseType)
    }
    
    
    
    
    @IBAction func bottonHistory(_ sender: Any) {
        self.performSegue(withIdentifier: "BottonHistory", sender: nil)
    }
    
    @IBAction func timerBottonAction(_ sender: UIButton) {
        if(self.labelTimerText.text == "30"){
            self.timer.invalidate()
            self.labelTimerText.text = ""
            self.seconds = 0.0
            return
        }
        if(self.labelTimerText.text == ""){
            self.labelTimerText.text = "1"
            self.seconds = 1.0
        }else if (self.labelTimerText.text == "1"){
            self.seconds = 5.0
            self.labelTimerText.text = "5"
        }else{
            self.seconds += 5.0
            let tmp = Int(self.seconds)
            self.labelTimerText.text = String(tmp)
        }
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: self.seconds, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    
    @objc func update(){
        let serviceLanding = ServiceLanding(type: self.choiseType)
        serviceLanding.callAPI()
        serviceLanding.completionHandler{ [weak self] (danger, status, message) in
            if status{
                guard let self = self else {return}
                guard let tmpDanger = danger else{return}
                self.status = tmpDanger.result
                self.f += 1
                print("\(self.status) \(self.f)" )
            }else{
                print(message)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != nil else{return}
        if(segue.identifier == "BottonHistory"){
            (segue.destination as! TableViewController2).type = self.choiseType
        }
    }
}
