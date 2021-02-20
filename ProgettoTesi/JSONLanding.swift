//
//  File.swift
//  ProgettoTesi
//
//  Created by mgonline on 20/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation

struct landing2 : Codable {
    var result : Bool
}
struct landing: Codable {
    var seconds: Double?
    var type: String?
}

let url = URL(string: "https://td4.andromedaesp.it/api/demo/landing")

guard let requestUrl = url else { fatalError() }

var request = URLRequest(url: requestUrl)
request.httpMethod = "POST"
request.setValue("application/json", forHTTPHeaderField: "Accept")
request.setValue("application/json", forHTTPHeaderField: "Content-Type")

let  det = detail(seconds: 0, type: "Mask")
let jsonData = try JSONEncoder().encode(det)

request.httpBody = jsonData

let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

    if let error = error {
        print("Error took place \(error)")
        return
    }
    guard let data = data else {return}

    do{
        let land = try JSONDecoder().decode(landing2.self, from: data)
        print("Response data:\n \(land.result)")
    }catch let jsonErr{
        print(jsonErr)
    }


}
task.resume()
