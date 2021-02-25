//
//  File.swift
//  ProgettoTesi
//
//  Created by mgonline on 21/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation
import UIKit

class Utente{
    
    
    var timestamp: Int
    var type: String
    var nPeople: Int?
    var description: String?
    var location: String?
    var media: String?
    var size: Int?
    var urlMedia: String
    var imgHystory: UIImage?
    var temperature : Double?
    var coughRateMin : Int?
    
    init(timestamp: Int, type: String, nPeople: Int) {
        self.timestamp = timestamp
        self.type = type
        self.nPeople = nPeople
        self.urlMedia = ""
    }
    
    
    init(timestamp: Int, type: String, temperature: Double, coughRateMin: Int) {
        self.timestamp = timestamp
        self.type = type
        self.temperature = temperature
        self.coughRateMin = coughRateMin
        self.urlMedia = ""
    }
}
