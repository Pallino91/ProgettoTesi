//
//  ModelUtente.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation
import UIKit

struct UtentiHystory : Codable{
    var timestamp: Int
    var type: String
    var value: HistoryMask
}
