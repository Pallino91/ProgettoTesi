//
//  ViewController2.swift
//  ProgettoTesi
//
//  Created by mgonline on 15/02/21.
//  Copyright © 2021 mgonline. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var avvenimentoDettaglio: UILabel!
    @IBOutlet weak var imgDettagli: UIImageView!
    @IBOutlet weak var dataDettaglio: UILabel!
    @IBOutlet weak var locationDettaglio: UILabel!
    @IBOutlet weak var imgUtente: UIImageView!
    
    var utenti : UtentiCovid?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avvenimentoDettaglio.text = "\(utenti!.numeroPersone) People Without Mask"
        imgDettagli.image = utenti?.img
        dataDettaglio.text = utenti?.data
        locationDettaglio.text = utenti?.location?.rawValue
        imgUtente.image = utenti?.imgUtente
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
