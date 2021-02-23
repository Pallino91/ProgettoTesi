//
//  LoadHistory.swift
//  ProgettoTesi
//
//  Created by mgonline on 22/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation

public class LoadHistory {
    @Published var utenti = [UtentiHystory]()
    
    init() {
        load()
    }
    
    func load(){
        let url = URL(string: "https://td4.andromedaesp.it/api/demo/history")
        let y = ["batchIndex": 1, "batchSize": 5, "reverseOrder": true, "time": 1593705153000, "type": "Mask"] as [String : Any]
        let jsonDataa = try! JSONSerialization.data(withJSONObject: y, options: [])
        var requestt = URLRequest(url: url!)
        requestt.httpMethod = "POST"
        //request.httpBody = postString.data(using: String.Encoding.utf8);
        //
        
        requestt.setValue("application/json", forHTTPHeaderField: "Accept")
        requestt.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestt.httpBody = jsonDataa
        //
        
        let taskk = URLSession.shared.dataTask(with: requestt) {(data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            if let c = response as? HTTPURLResponse, c.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(c.statusCode)")
                print("response = \(response)")
            }
            do{
                //here dataResponse received from a network request
                let l = try JSONDecoder().decode([UtentiHystory].self, from: data!)
                self.utenti = l
                //let jsonResponse = try JSONSerialization.jsonObject(with:
                //dataResponse, options: [])
                //print("xx")
                //                for x in land{
                //                    self.utenti.append(Utente(timestamp: x.timestamp , type: x.type, nPeople: x.value.nPeople))
                //                    print("eee")
                //                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }.resume()
    }
}
