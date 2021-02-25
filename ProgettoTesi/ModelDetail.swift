//
//  ModelDetail.swift
//  ProgettoTesi
//
//  Created by mgonline on 22/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation
import UIKit

struct DetailResponse: Codable {
    var description: String?
    var location: String?
    var media: String?
    var size: Int?
    var timestamp: Int?
    var type: String?
    var url: String?
}

struct DetailRequest: Codable {
    var timestamp: Int
    var type: String
}
