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
    var seconds : Double = 0.0
    var timer = Timer()
    var f = 1
    var status : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgInizio.layer.cornerRadius = 90
        imgInizio.layer.borderWidth = 3
        imgInizio.layer.masksToBounds = true
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
        let url = URL(string: "https://td4.andromedaesp.it/api/demo/landing")
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTodoItem = LandingRequest(seconds: self.seconds, type: "Mask")
        let jsonData = try! JSONEncoder().encode(newTodoItem)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            
            do{
                let land = try JSONDecoder().decode(LandingResponse.self, from: data)
                DispatchQueue.main.async{
                    self.status = land.result
                    self.f+=1
                    print("\(self.status) \(self.f)")
                }
            }catch let jsonErr{
                print(jsonErr)
            }
            
            
        }
        task.resume()
    }
}

