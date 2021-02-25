//
//  SeriviceLanding.swift
//  ProgettoTesi
//
//  Created by mgonline on 25/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation
import Alamofire


class ServiceLanding{
    
    fileprivate var url : URL = URL(string: "https://td4.andromedaesp.it/api/demo/landing")!
    fileprivate var request : URLRequest?
    
    typealias returnUtenti = (_ danger: LandingResponse?, _ status: Bool, _ message: String) -> Void
    var callUtenti : returnUtenti?
    var type : String?
    
    init(type: String) {
        self.type = type
    }
    
    func callAPI(){
        callRequest()
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200,201]))
        AF.request(self.request!).uploadProgress{progress in}.response{response in
            guard let data = response.data, response.error == nil else {
                self.callUtenti?(nil,false,"\(response.error?.localizedDescription) Response Landing Error")
                return}
            print(response.response!.statusCode)
            do{
                let result = try JSONDecoder().decode(LandingResponse.self, from: data)
                self.callUtenti?(result,true,"")
            }catch{
                self.callUtenti?(nil,false,"Landing Decode Error " + error.localizedDescription)
            }
            // print(response.response?.description)
        }
    }
    
    func completionHandler(callUtenti: @escaping returnUtenti){
        self.callUtenti = callUtenti
    }
    
    func callRequest(){
        let newTodoItem = LandingRequest(seconds: 60, type: self.type)
        let jsonData = try! JSONEncoder().encode(newTodoItem)
        self.request = URLRequest(url: self.url)
        self.request?.httpMethod = "POST"
        self.request!.setValue("application/json", forHTTPHeaderField: "Accept")
        self.request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request?.httpBody = jsonData
        
    }
}
