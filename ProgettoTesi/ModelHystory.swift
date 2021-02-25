//
//  ModelUtente.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation
import UIKit


struct HistoryMask: Codable{
    var nPeople: Int
    var type: String
}

struct UtentiHistoryMaskResponse : Codable{
    var timestamp: Int
    var type: String
    var value: HistoryMask
}

struct UtentiHistoryMaskRequest : Codable {
    var batchIndex: Int
    var batchSize: Int
    var reverseOrder: Bool
    var time: Int
    var type: String
}

struct HistoryCorona: Codable{
    var type: String
    var temperature: Double
    var coughRateMin: Int
}

struct UtentiHistoryCoronaResponse : Codable{
    var timestamp: Int
    var type: String
    var value: HistoryCorona
}





