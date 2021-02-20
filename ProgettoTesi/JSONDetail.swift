//
//  JSONDetail.swift
//  ProgettoTesi
//
//  Created by mgonline on 20/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation


var urll = URL(string: "https://td4.andromedaesp.it/api/demo/detail")
let x = ["timestamp": 0, "type": "Mask"] as [String : Any]
let jsonData = try! JSONSerialization.data(withJSONObject: x, options: [])
var request = URLRequest(url: urll!)
request.httpMethod = "POST"

request.setValue("application/json", forHTTPHeaderField: "Accept")
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
request.httpBody = jsonData
//

let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    guard let dataResponse = data,
        error == nil else {
            print(error?.localizedDescription ?? "Response Error")
            return }
   if let c = response as? HTTPURLResponse, c.statusCode != 200 {
        // check for http errors
        print("\(c.statusCode)")
        print("response = \(response)")
    }
    do{
        let jsonResponse = try JSONSerialization.jsonObject(with:
            dataResponse, options: [])
        print(jsonResponse)
    } catch let parsingError {
        print("Error", parsingError)
    }
}
task.resume()
