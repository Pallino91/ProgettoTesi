//
//  ServiceDetail.swift
//  ProgettoTesi
//
//  Created by mgonline on 25/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation
import Alamofire


class ServiceDetail{
    
    fileprivate var url : URL = URL(string: "https://td4.andromedaesp.it/api/demo/detail")!
    fileprivate var request : URLRequest?
    fileprivate var time : Int?
    fileprivate var type : String?
    
    typealias returnUtenti = (_ danger: [DetailResponse]?, _ status: Bool, _ message: String) -> Void
    var callUtenti : returnUtenti?
    
    init(time: Int, type: String) {
        self.time = time
        self.type = type
    }
    
    func callAPI(){
        callRequest()
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200]))
        AF.request(self.request!).uploadProgress{progress in}.response(responseSerializer: serializer){response in
            guard let data = response.data, response.error == nil else {
                self.callUtenti?(nil,false,"\(response.error?.localizedDescription) Response Landing Error")
                return}
            print(serializer)
            print("-------------------------")
            do{
                let result = try JSONDecoder().decode([DetailResponse].self, from: data)
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
        var jsonRequest = ["timestamp": self.time, "type": self.type] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonRequest, options: [])
        self.request = URLRequest(url: self.url)
        self.request?.httpMethod = "POST"
        self.request!.setValue("application/json", forHTTPHeaderField: "Accept")
        self.request!.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request?.httpBody = jsonData
    }
}
