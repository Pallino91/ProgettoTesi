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
    @IBOutlet weak var media: UILabel!
    
    var utenti : Utente?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avvenimentoDettaglio.text = "\(utenti!.nPeople) People Without Mask"
        imgDettagli.image = utenti?.imgHystory
        locationDettaglio.text = utenti?.location
        let data = try? Data(contentsOf: URL(string: "https://td4.andromedaesp.it\(utenti!.urlMedia)")!)
        imgUtente.image = UIImage(data: data!)
        media.text = utenti!.media
        let date = NSDate(timeIntervalSince1970: TimeInterval(utenti!.timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM-dd-y HH:mm:ss"
        dataDettaglio.text = dateFormatter.string(from: date as Date)
        DispatchQueue.main.async{
            self.viewDidLoad()
        }
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
