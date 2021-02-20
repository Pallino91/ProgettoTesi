//
//  JSONHistory.swift
//  ProgettoTesi
//
//  Created by mgonline on 20/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation


let url = URL(string: "https://td4.andromedaesp.it/api/demo/history")
let y = ["batchIndex": 0, "batchSize": 0, "reverseOrder": true, "time": 0, "type": "Mask"] as [String : Any]
let jsonDataa = try! JSONSerialization.data(withJSONObject: y, options: [])
var request = URLRequest(url: url!)
request.httpMethod = "POST"


request.setValue("application/json", forHTTPHeaderField: "Accept")
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
request.httpBody = jsonDataa
//

let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    guard let dataResponse = data,
        error == nil else {
            print(error?.localizedDescription ?? "Response Error")
            return }
    if let c = response as? HTTPURLResponse, c.statusCode != 200 {
        print("\(c.statusCode)")
        print("response = \(response)")
    }
    do{
        let jsonResponse = try JSONSerialization.jsonObject(with:
            dataResponse, options: [])
        print(jsonResponse) //Response result
    } catch let parsingError {
        print("Error", parsingError)
    }
}
task.resume()
