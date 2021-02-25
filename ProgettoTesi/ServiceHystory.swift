//
//  ServiceHystory.swift
//  ProgettoTesi
//
//  Created by mgonline on 24/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation
import Alamofire

class ServiceHystory{
    
    fileprivate var type : String?
    fileprivate var url : URL = URL(string: "https://td4.andromedaesp.it/api/demo/history")!
    fileprivate var request : URLRequest?
    
    typealias returnUtentiMask = (_ utenti:[UtentiHistoryMaskResponse]?, _ status: Bool, _ message: String) -> Void
     typealias returnUtentiCorona = (_ utenti:[UtentiHistoryCoronaResponse]?, _ status: Bool, _ message: String) -> Void
    var callUtentiMask : returnUtentiMask?
    var callUtentiCorona : returnUtentiCorona?
    
    init(type: String) {
        self.type = type
        switch self.type {
        case "Mask":
            callAPIMask()
        case "Coronavirus":
            callAPICorona()
        default:
            break
        }
    }
    
    func callAPIMask(){
        callRequestMask()
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200]))
        AF.request(self.request!).uploadProgress{progress in}.response{response in
            guard let data = response.data, response.error == nil else {
                self.callUtentiMask?(nil,false,"\(response.error?.localizedDescription) Response Hystory Error")
                return}
            do{
                let result = try JSONDecoder().decode([UtentiHistoryMaskResponse].self, from: data)
                self.callUtentiMask?(result,true,"")
            }catch{
                self.callUtentiMask?(nil,false,"Hystory Decode Error " + error.localizedDescription)
            }
            // print(response.response?.description)
        }
    }
    
    func callAPICorona(){
        callRequestCorona()
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200]))
        AF.request(self.request!).uploadProgress{progress in}.response{response in
            guard let data = response.data, response.error == nil else {
                self.callUtentiCorona?(nil,false,"\(response.error?.localizedDescription) Response Hystory Error")
                return}
            do{
                let result = try JSONDecoder().decode([UtentiHistoryCoronaResponse].self, from: data)
                self.callUtentiCorona?(result,true,"")
            }catch{
                self.callUtentiCorona?(nil,false,"Hystory Decode Error " + error.localizedDescription)
            }
            // print(response.response?.description)
        }
    }
    
    func completionHandlerMask(callUtentiMask: @escaping returnUtentiMask){
        self.callUtentiMask = callUtentiMask
    }
    
    func completionHandlerCorona(callUtentiCorona: @escaping returnUtentiCorona){
        self.callUtentiCorona = callUtentiCorona
    }
    
    func callRequestMask(){
        let jsonRequest = ["batchIndex": 1, "batchSize": 10, "reverseOrder": true, "time": 1593705153000, "type": "Mask"] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonRequest, options: [])
        self.request = URLRequest(url: self.url)
        self.request?.httpMethod = "POST"
        self.request!.setValue("application/json", forHTTPHeaderField: "Accept")
        self.request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request?.httpBody = jsonData
        
    }
    
    func callRequestCorona(){
           let jsonRequest = ["batchIndex": 1, "batchSize": 10, "reverseOrder": true, "time": 1593705153000, "type": "Coronavirus"] as [String : Any]
           let jsonData = try! JSONSerialization.data(withJSONObject: jsonRequest, options: [])
           self.request = URLRequest(url: self.url)
           self.request?.httpMethod = "POST"
           self.request!.setValue("application/json", forHTTPHeaderField: "Accept")
           self.request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
           self.request?.httpBody = jsonData
           
       }
}
