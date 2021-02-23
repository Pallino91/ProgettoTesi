//
//  ModelLanding.swift
//  ProgettoTesi
//
//  Created by mgonline on 23/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation
import UIKit


struct LandingResponse : Codable {
    var result : Bool
}
struct LandingRequest: Codable {
    var seconds: Double?
    var type: String?
}
