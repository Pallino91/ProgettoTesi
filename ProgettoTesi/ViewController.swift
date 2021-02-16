//
//  ViewController.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelTimerText: UILabel!
    
    @IBOutlet weak var imgInizio: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgInizio.layer.cornerRadius = 90
        imgInizio.layer.borderWidth = 3
        imgInizio.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func timerBottonAction(_ sender: UIButton) {
        switch labelTimerText.text {
        case "":
            labelTimerText.text = "15"
        case "15":
            labelTimerText.text = "30"
        case "30":
            labelTimerText.text = "45"
        case "45":
            labelTimerText.text = "60"
        case "60":
            labelTimerText.text = ""
        default:
            break
        }
    }
    
    
}

