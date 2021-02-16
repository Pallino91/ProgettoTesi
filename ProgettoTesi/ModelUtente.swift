//
//  ModelUtente.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import Foundation
import UIKit

struct UtentiCovid {
    var avvenimento : String
    var data : String
    var img : UIImage?
    var location : Location?
    var imgUtente : UIImage?
    var numeroPersone : String
    
    init(avvenimento: String, data: String, numeroPersone: String) {
        self.avvenimento = avvenimento
        self.data = data
        self.numeroPersone = numeroPersone
    }
}
